import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/feature/song/data/models/new_song.dart';
import 'package:musify/feature/song/screens/song_details_screen.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';

class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.title,
    required this.songs,
    this.menuItems,
  });
  final String title;
  final List<Song> songs;
  final List<PopupMenuItem>? menuItems;

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                whiteTextMedium(title),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // AppNavigator.push(
                      // PlaylistScreen(
                      //   title: title,
                      //   songs: songs,
                      //   menuItems: menuItems,
                      // ),
                    // );
                  },

                  child: darkText('View all'),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                  itemCount: songs.length,
                  scrollDirection: .horizontal,
                  itemBuilder: (context, index) {
                    Song song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => AppNavigator.push(
                          SongDetailsScreen(song: songs[index]),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: song.media.coverImage,

                          placeholder: (context, url) => Container(
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          imageBuilder: (context, imageProvider) => Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: whiteTextSmall(song.title),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
