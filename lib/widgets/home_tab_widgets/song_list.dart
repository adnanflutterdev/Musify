import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musify/screens/playlist_screen.dart';
import 'package:musify/screens/song_details_screen.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/text.dart';

class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.title,
    required this.songs,
    this.editable = false,
    this.canEditSongsList = false,
    this.isFavouriteVisible = false,
  });
  final String title;
  final List<Song> songs;
  final bool editable;
  final bool canEditSongsList;
  final bool isFavouriteVisible;

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return SizedBox(width: 1, height: 1);
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistScreen(
                        title: title,
                        songs: songs,
                        isFavouriteVisible: isFavouriteVisible,
                        editable: editable,
                        canEditSongsList: canEditSongsList,
                      ),
                    ),
                  ),
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
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                  itemCount: songs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Song song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SongDetailsScreen(song: songs[index]),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: song.coverImage,

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
                                child: whiteTextSmall(song.songName),
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
