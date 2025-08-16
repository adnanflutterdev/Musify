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
import 'package:musify/widgets/song_track.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({
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
      backgroundColor: AppColors.primaryBackground,
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
                    backgroundColor: AppColors.cardBackground,
                    automaticallyImplyLeading: false,

                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxHeight = constraints.maxHeight;
                        double imageSize =
                            ((maxHeight - kToolbarHeight) /
                                (220 - kToolbarHeight)) *
                            90;
                        imageSize = imageSize.clamp(30, 90);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Center(
                                child: imageSize == 30
                                    ? appBarText(title)
                                    : Container(
                                        width: imageSize * 2 + 16,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: GridView.builder(
                                          itemCount: songs.length > 4
                                              ? 4
                                              : songs.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 0,
                                                mainAxisSpacing: 0,
                                              ),
                                          itemBuilder: (context, index) =>
                                              CachedNetworkImage(
                                                imageUrl:
                                                    songs[index].coverImage,
                                                imageBuilder:
                                                    (
                                                      context,
                                                      imageProvider,
                                                    ) => Container(
                                                      width: imageSize,
                                                      height: imageSize,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                              ),
                                        ),
                                      ),
                              ),
                            ),
                            const Spacer(),
                            if (imageSize != 30)
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
            SongTrack(),
          ],
        ),
      ),
    );
  }
}
