import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/song_stream_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/buttons/favourite_button.dart';
import 'package:musify/widgets/buttons/play_button.dart';
import 'package:musify/widgets/search_tab_widgets/song_tile.dart';
import 'package:musify/widgets/song_selection_bar.dart';
import 'package:musify/widgets/song_track.dart';

class FeaturedPlaylistScreen extends StatelessWidget {
  const FeaturedPlaylistScreen({
    super.key,
    required this.title,
    required this.songs,
    this.isFavouriteVisible = false,
  });
  final String title;
  final List<Song> songs;
  final bool isFavouriteVisible;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions(SizedBox spacer) {
      if (isFavouriteVisible) {
        return [FavouriteButton(songId: ''), spacer, PlayButton(songs: songs)];
      }
      return [PlayButton(songs: songs)];
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(backgroundColor: AppColors.surfaceDark, toolbarHeight: 1),
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
                                  .clamp(30, 90);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                child: imageSize == 30
                                    ? appBarText(title)
                                    : SizedBox(
                                        width: imageSize * 2 + 20,
                                        child: Center(
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: songLength > 2
                                                ? WrapAlignment.start
                                                : WrapAlignment.center,
                                            children: List.generate(
                                              songLength,
                                              (index) {
                                                return CachedNetworkImage(
                                                  imageUrl:
                                                      songs[index].coverImage,
                                                  width: songLength == 1
                                                      ? imageSize * 1.35
                                                      : imageSize,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            const Spacer(),
                            if (imageSize > 30)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: actions(h10),
                              ),
                            if (imageSize == 30)
                              Center(child: Row(children: actions(w20))),
                            w20,
                          ],
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: h20),
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
