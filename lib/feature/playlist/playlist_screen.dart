import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/song/models/song.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/spacers.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/core/widgets/buttons/more_button.dart';
import 'package:musify/core/widgets/buttons/play_button.dart';
import 'package:musify/feature/search/widgets/song_tile.dart';
import 'package:musify/feature/song/widgets/song_selection_bar.dart';
import 'package:musify/feature/song/widgets/song_track.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({
    super.key,
    required this.title,
    required this.songs,
    required this.isFavouriteVisible,
    required this.editable,
    required this.canEditSongsList,
  });
  final String title;
  final List<Song> songs;
  final bool isFavouriteVisible;
  final bool editable;
  final bool canEditSongsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(toolbarHeight: 1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // AppBar
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 220,
                    backgroundColor: AppColors.surfaceDark,
                    automaticallyImplyLeading: false,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxHeight = constraints.maxHeight;
                        int songLength = songs.length.clamp(0, 4);
                        double imageSize = songLength < 3
                            ? maxHeight / 1.75
                            : (((maxHeight - kToolbarHeight) /
                                          (220 - kToolbarHeight)) *
                                      90)
                                  .clamp(40, 90);

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Pop button
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.surfaceWhite,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: SizedBox(
                                  width: imageSize * 2 + 20,
                                  child: Center(
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: songLength > 2
                                          ? WrapAlignment.start
                                          : WrapAlignment.center,
                                      children: List.generate(songLength, (
                                        index,
                                      ) {
                                        return CachedNetworkImage(
                                          imageUrl: songs[index].coverImage,
                                          width: songLength == 1
                                              ? imageSize * 1.35
                                              : imageSize,
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (imageSize > 40) const Spacer(),
                            if (imageSize > 40)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [PlayButton(songs: songs)],
                              ),
                            if (imageSize == 40)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [PlayButton(songs: songs)],
                              ),
                            if (imageSize == 40) const Spacer(),
                            w20,
                          ],
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: [
                          appBarText(title),
                          const Spacer(),
                          if (editable || canEditSongsList)
                            MoreButton(
                              title: title,
                              editable: editable,
                              canAddSongs: canEditSongsList,
                            ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: h10),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      Song song = songs[index];
                      return Consumer(
                        builder: (context, ref, child) {
                          final songStream = ref.watch(songStreamProvider);
                          final currentSongId =
                              songStream.asData?.value.mediaItem?.id;
                          return SongTile(
                            song: song,
                            isSameSong: song.url == currentSongId,
                          );
                        },
                      );
                    }, childCount: songs.length),
                  ),
                ],
              ),
            ),
            SongSelectionBar(),
            SongTrack(),
          ],
        ),
      ),
    );
  }
}
