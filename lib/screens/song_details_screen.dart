import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/duration_label.dart';
import 'package:musify/utils/screen_size.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/buttons/favourite_button.dart';
import 'package:musify/widgets/buttons/play_button.dart';
import 'package:musify/widgets/song_track.dart';
import 'package:musify/widgets/tag.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen({super.key, required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    double coverImageSize = ScreenSize.width / 1.5;
    int duration = song.duration;
    List<Set<String>> songDetails = [
      {'From: ', song.movieName},
      {'Duration: ', '${durationLabel(duration)} min'},
      {'Released: ', song.date},
      {'Listens:  ', song.listen.toString()},
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: Column(
          children: [
            Container(
              color: AppColors.cardBackground,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                    Expanded(
                      child: doubleText(
                        text1: song.songName,
                        style1: TextStyle(
                          color: AppColors.primaryPink,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        text2: song.artistName,
                        style2: TextStyle(
                          color: AppColors.textMedium,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h20,
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: song.coverImage,
                          placeholder: (context, url) => Container(
                            width: coverImageSize,
                            height: coverImageSize,
                            decoration: BoxDecoration(
                              color: AppColors.musicTrackBackground,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: coverImageSize,
                            height: coverImageSize,
                            decoration: BoxDecoration(
                              color: AppColors.musicTrackBackground,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FavouriteButton(songId: song.id, size: 40),
                          w10,
                          PlayButton(songs: [song], size: 40),
                          w20,
                        ],
                      ),
                      // Song Details here
                      songDetailsHeading('Details:'),
                      h10,
                      Wrap(
                        children: List.generate(songDetails.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              width: ScreenSize.width / 2.2,
                              child: doubleText(
                                text1: songDetails[index].first,
                                style1: TextStyle(
                                  color: AppColors.textMedium,
                                  fontSize: 16,
                                ),
                                text2: songDetails[index].last != ''
                                    ? songDetails[index].last[0].toUpperCase() +
                                          songDetails[index].last.substring(1)
                                    : '_______',
                                style2: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      songDetailsHeading('Language(s):'),
                      Row(
                        children: [
                          Wrap(
                            children: song.language
                                .toString()
                                .split(',')
                                .map(
                                  (e) =>
                                      tag(e[0].toUpperCase() + e.substring(1)),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      h10,
                      songDetailsHeading('Categories:'),
                      Wrap(
                        children: song.songCategories
                            .toString()
                            .split(', ')
                            .map(
                              (e) => tag(e[0].toUpperCase() + e.substring(1)),
                            )
                            .toList(),
                      ),
                      h20,
                    ],
                  ),
                ),
              ),
            ),
            SongTrack(),
          ],
        ),
      ),
    );
  }
}
