import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musify/services/modals/song_stream.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with SeekHandler, QueueHandler {
  final AudioPlayer _player = AudioPlayer();
  final List<MediaItem> _playList = [];
  int _lastIndex = -1;

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

  AudioPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    // Set up audio Session
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    // Forward JustAudio states to AudioService
    _player.playbackEventStream.listen((event) {
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
        .map((e) => AudioSource.uri(Uri.parse(e.id)))
        .toList();

    // set playlist to player
    await _player.setAudioSources(sources, initialIndex: index);

    await _player.play();
  }

  Future<void> onSongChanged(String songId, int listen) async {
    final fireStore = FirebaseFirestore.instance;
    await fireStore.collection('Songs').doc(songId).update({
      'listen': listen + 1,
    });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await fireStore.collection('userData').doc(uid).get();
    List recentlyPlayed = snapshot.get('recentlyPlayed');
    if (recentlyPlayed.contains(songId)) {
      recentlyPlayed.remove(songId);
      recentlyPlayed.insert(0, songId);
    } else {
      recentlyPlayed.insert(0, songId);
    }
    await fireStore.collection('userData').doc(uid).update({
      'recentlyPlayed': recentlyPlayed,
    });
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
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

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
