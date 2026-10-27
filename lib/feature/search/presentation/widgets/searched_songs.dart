import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/snack_bars.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';
import 'package:musify/feature/search/presentation/widgets/song_tile.dart';
import 'package:musify/feature/song/providers/songs_provider.dart';

class SearchedSongs extends ConsumerStatefulWidget {
  const SearchedSongs({super.key});

  @override
  ConsumerState<SearchedSongs> createState() => _SearchedSongsState();
}

class _SearchedSongsState extends ConsumerState<SearchedSongs> {
  final ValueNotifier<bool> _isLoadingNewSongs = ValueNotifier(false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (!_isLoadingNewSongs.value) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _isLoadingNewSongs.value = true;
          loadMoreSongs();
        }
      }
    });
  }

  Future<void> loadMoreSongs() async {
    final songsNotifier = ref.read(songsProvider.notifier);

    final result = await songsNotifier.loadMoreSongs();

    if (!result.success && mounted) {
      showAppSnackbar(context: context, result: result);
    }

    _isLoadingNewSongs.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final songsRef = ref.watch(songsProvider);
    final songStream = ref.watch(songStreamProvider);
    final currentSongId = songStream.asData?.value.mediaItem?.id;

    return AsyncWhen(
      value: songsRef,
      onData: (songs) {
        if (songs.isEmpty) {
          return const Text('No Songs Found');
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                itemCount: songs.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  Song song = songs[index];

                  return SongTile(
                    song: song,
                    isSameSong: song.id == currentSongId,
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isLoadingNewSongs,
              builder: (context, value, child) {
                if (value) {
                  return const Column(
                    children: [
                      AppSpacing.h16,
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
