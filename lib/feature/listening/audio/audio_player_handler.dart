import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/core/utils/app_preferences.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_history_usecase.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_usecase.dart';
import 'package:musify/feature/listening/presentation/providers/listening_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:musify/feature/song/data/models/song_stream.dart';
import 'package:uuid/uuid.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with SeekHandler, QueueHandler {
  final AudioPlayer _player = AudioPlayer();
  final List<MediaItem> _playList = [];
  int _lastIndex = -1;
  DateTime? _playedAt;

  final ProviderContainer provider;

  Stream<SongStream> get songStream {
    return Rx.combineLatest6<
      Duration,
      Duration,
      MediaItem?,
      PlaybackState,
      bool,
      LoopMode,
      SongStream
    >(
      _player.positionStream.startWith(Duration.zero),
      _player.bufferedPositionStream,
      mediaItem.stream,
      playbackState.stream,
      _player.shuffleModeEnabledStream,
      _player.loopModeStream,
      (
        currentPosition,
        bufferedPosition,
        mediaItem,
        playBackState,
        shuffleMode,
        loopMode,
      ) {
        return SongStream(
          bufferedPosition.inSeconds.toDouble(),
          currentPosition.inSeconds.toDouble(),
          mediaItem,
          playBackState,
          shuffleMode,
          loopMode,
        );
      },
    );
  }

  AudioPlayerHandler(this.provider) {
    _init();
  }

  Future<void> _init() async {
    // Set up audio Session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    LastPlayedSong? lastPlayedSong = AppPreferences.getLastPlayedSong();
    if (lastPlayedSong != null) {
      debugPrint('\n\nLast played song need to be synced!!!!');
      await updateRecentlyPlayed(
        completed: false,
        lastPlayedSong: lastPlayedSong,
      );
      debugPrint('\n\nDeleting last played song after syncing');
      AppPreferences.deleteLastPlayedSong();
    } else {
      debugPrint('\n\nNo need to sync songs!!!!');
    }

    // Forward JustAudio states to AudioService
    _player.playbackEventStream.listen((event) async {
      bool playing = _player.playing;

      final processingState = _transformProcessingState(
        _player.processingState,
      );
      playbackState.add(
        playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            playing ? MediaControl.pause : MediaControl.play,
            MediaControl.skipToNext,
            MediaControl.stop,
          ],
          systemActions: {
            MediaAction.seek,
            MediaAction.seekForward,
            MediaAction.seekBackward,
          },
          androidCompactActionIndices: const [0, 1, 2],
          processingState: processingState,
          playing: playing,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
          queueIndex: _player.currentIndex,
        ),
      );

      if (processingState == .completed) {
        debugPrint('\n\nSong Completed\n\n');
        await updateRecentlyPlayed(completed: true);
        if (!_player.hasNext) {
          debugPrint("\n\nNo songs are in queue. We can delete last played song");
          AppPreferences.deleteLastPlayedSong();
        }
      }
    });

    _player.currentIndexStream.listen((index) async {
      if (index != null && queue.value.isNotEmpty && _lastIndex != index) {
        _lastIndex = index;
        final item = queue.value[index];
        mediaItem.add(item);

        final extras = item.extras;
        if (extras != null) {
          await onSongChanged(extras['songId'], extras['listen']);
        } else {}
      }
    });
  }

  Future<void> toggleSuffleMode() async {
    final isShuffled = _player.shuffleModeEnabled;
    await _player.setShuffleModeEnabled(!isShuffled);
    playbackState.value.copyWith(
      shuffleMode: isShuffled
          ? AudioServiceShuffleMode.none
          : AudioServiceShuffleMode.all,
    );
  }

  Future<void> loopSongs(LoopMode loopMode) async {
    await _player.setLoopMode(loopMode);
    playbackState.value.copyWith(repeatMode: repeatMode(loopMode));
  }

  Future<void> playSong(MediaItem mediaItem) async {
    _playList.add(mediaItem);
    final index = _playList.length - 1;

    final newQueue = [...queue.value, mediaItem];
    queue.add(newQueue);

    this.mediaItem.add(mediaItem);

    await _player.insertAudioSource(
      index,
      AudioSource.uri(Uri.parse(mediaItem.id), tag: mediaItem),
    );

    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  Future<void> clearPlaylist() async {
    await _player.stop();
    _playList.clear();
    queue.add([]);
    await _player.clearAudioSources();
  }

  Future<void> playPlaylist(List<MediaItem> mediaItems, int index) async {
    // clears previous data
    await clearPlaylist();
    _lastIndex = -1;

    _playList.addAll(mediaItems);

    // send data to audio service
    queue.add(_playList);

    // convert to AudioSources
    final sources = _playList
        .map(
          (mediaItem) =>
              AudioSource.uri(Uri.parse(mediaItem.id), tag: mediaItem),
        )
        .toList();

    // set playlist to player
    await _player.setAudioSources(sources, initialIndex: index);

    await _player.play();
  }

  Future<void> onSongChanged(String songId, int listen) async {
    _playedAt = DateTime.now();
    AppPreferences.setLastPlayedSong(
      LastPlayedSong(
        songId: songId,
        playedAt: _playedAt ?? DateTime.now(),
        duration: _player.duration?.inSeconds ?? 0,
      ),
    );
    Future.delayed(const Duration(seconds: 30), () {
      if (songId == queue.value[_player.currentIndex ?? 0].extras?['songId']) {
        provider
            .read(listeningProvider.notifier)
            .playCountIncrement(IdParam(songId));
      } else {
        if (kDebugMode) {
          debugPrint('Song Changed!!!');
        }
      }
    });
  }

  Future<void> updateRecentlyPlayed({
    required bool completed,
    LastPlayedSong? lastPlayedSong,
  }) async {
    final recentlyPlayedState = provider.read(recentlyPlayedProvider);
    final recentlyPlayedSongs = recentlyPlayedState.when(
      data: (songs) => songs,
      loading: () => <RecentlyPlayed>[],
      error: (error, stackTrace) => <RecentlyPlayed>[],
    );
    final DateTime now = DateTime.now();
    final notifier = provider.read(listeningProvider.notifier);
    String songId = lastPlayedSong != null
        ? lastPlayedSong.songId
        : queue.value[_player.currentIndex ?? 0].extras?['songId'];

    bool canUpdate = recentlyPlayedSongs.map((r) => r.songId).contains(songId);
    String? docToBeDeleted = (recentlyPlayedSongs.length == 20 && canUpdate)
        ? recentlyPlayedSongs.last.songId
        : null;

    RecentlyPlayed recentlyPlayed;
    RecentlyPlayedHistory recentlyPlayedHistory;

    if (lastPlayedSong != null) {
      recentlyPlayed = RecentlyPlayed(
        songId: songId,
        playedAt: lastPlayedSong.playedAt,
        completed: completed,
        durationPlayed: lastPlayedSong.duration,
      );

      recentlyPlayedHistory = RecentlyPlayedHistory(
        id: const Uuid().v4(),
        songId: songId,
        completed: completed,
        durationPlayed: lastPlayedSong.duration,
        startedAt: lastPlayedSong.playedAt,
        endedAt: lastPlayedSong.playedAt.add(
          Duration(seconds: lastPlayedSong.duration),
        ),
      );
    } else {
      recentlyPlayed = RecentlyPlayed(
        songId: songId,
        playedAt: _playedAt ?? now,
        completed: completed,
        durationPlayed: _player.position.inSeconds,
      );

      recentlyPlayedHistory = RecentlyPlayedHistory(
        id: const Uuid().v4(),
        songId: songId,
        completed: completed,
        durationPlayed: _player.position.inSeconds,
        startedAt: _playedAt ?? now,
        endedAt: now,
      );
    }

    await notifier.addRecentlyPlayed(
      AddRecentlyPlayedParams(
        recentlyPlayed: recentlyPlayed,
        canUpdate: canUpdate,
        docToBeDeleted: docToBeDeleted,
      ),
    );
    await notifier.addRecentlyPlayedHistory(
      AddRecentlyPlayedHistoryParams(recentlyPlayedHistory),
    );

    debugPrint('History Updated');

    provider.invalidate(recentlyPlayedProvider);
    provider.invalidate(recentlyPlayedHistoryProvider);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final newQueue = [...queue.value, mediaItem];
    queue.add(newQueue);
  }

  Future<void> changeShuffleMode(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> skipToNext() async {
    await updateRecentlyPlayed(completed: false);
    await _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await updateRecentlyPlayed(completed: false);
    await _player.seekToPrevious();
  }

  AudioServiceRepeatMode repeatMode(LoopMode loopMode) {
    switch (loopMode) {
      case LoopMode.all:
        return AudioServiceRepeatMode.all;
      case LoopMode.one:
        return AudioServiceRepeatMode.one;
      case LoopMode.off:
        return AudioServiceRepeatMode.one;
    }
  }

  AudioProcessingState _transformProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }
}
