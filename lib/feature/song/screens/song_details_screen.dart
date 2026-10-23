import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/feature/song/data/models/new_song.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/core/widgets/buttons/favourite_button.dart';
import 'package:musify/core/widgets/buttons/play_button.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/feature/song/widgets/song_track.dart';
import 'package:musify/feature/song/widgets/tag.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen({super.key, required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    double coverImageSize = ScreenSize.width / 1.5;
    int duration = song.media.duration;
    List<Set<String>> songDetails = [
      {'From: ', song.context.movie?.name ?? ''},
      {'Duration: ', '${durationLabel(duration)} min'},
      {
        'Released: ',
        song.release.releaseDate != null
            ? DateFormat('dd-MM-yyyy').format(song.release.releaseDate!)
            : '',
      },
      {'Listens:  ', song.stats.playCount.toString()},
    ];
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(backgroundColor: AppColors.surfaceDark, toolbarHeight: 1),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: doubleText(
                text1: song.title,
                style1: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                text2: song.getArtists(),
                style2: const TextStyle(
                  color: AppColors.onSurfaceMedium,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.h20,
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: song.media.coverImage,
                          placeholder: (context, url) => Container(
                            width: coverImageSize,
                            height: coverImageSize,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: coverImageSize,
                            height: coverImageSize,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.h12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FavouriteButton(songId: song.id, size: 40),
                          AppSpacing.w12,
                          PlayButton(song: song, size: 40),
                          AppSpacing.w20,
                        ],
                      ),
                      // Song Details here
                      songDetailsHeading('Details:'),
                      AppSpacing.h12,
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                        child: Wrap(
                          children: List.generate(songDetails.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SizedBox(
                                width: ScreenSize.width / 2.3,
                                child: doubleText(
                                  text1: songDetails[index].first,
                                  style1: const TextStyle(
                                    color: AppColors.onSurfaceMedium,
                                  ),
                                  text2: songDetails[index].last != ''
                                      ? songDetails[index].last[0]
                                                .toUpperCase() +
                                            songDetails[index].last.substring(1)
                                      : '_______',
                                  style2: const TextStyle(
                                    color: AppColors.surfaceWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      songDetailsHeading('Language(s):'),
                      Row(
                        children: [
                          Wrap(
                            children: song.classification.languages
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
                      AppSpacing.h12,
                      songDetailsHeading('Genre(s):'),
                      Wrap(
                        children: song.classification.genres
                            .toString()
                            .split(', ')
                            .map(
                              (e) => tag(e[0].toUpperCase() + e.substring(1)),
                            )
                            .toList(),
                      ),
                      AppSpacing.h20,
                    ],
                  ),
                ),
              ),
            ),
            const SongTrack(),
          ],
        ),
      ),
    );
  }
}
