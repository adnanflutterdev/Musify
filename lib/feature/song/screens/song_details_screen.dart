import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/feature/song/data/models/song.dart';

import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/screen_size.dart';

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
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        toolbarHeight: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: song.title,
                      style: context.text.headlineMedium,
                    ),
                    TextSpan(
                      text: song.getArtists(),
                      style: context.text.titleLarge,
                    ),
                  ],
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
                              color: context.colors.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: coverImageSize,
                            height: coverImageSize,
                            decoration: BoxDecoration(
                              color: context.colors.surfaceVariant,
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
                      const Text('Details:'),
                      AppSpacing.h12,
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                        child: Wrap(
                          children: List.generate(songDetails.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SizedBox(
                                width: ScreenSize.width / 2.3,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: songDetails[index].first,
                                        style: context.text.headlineMedium,
                                      ),
                                      TextSpan(
                                        text: songDetails[index].last != ''
                                            ? songDetails[index].last[0]
                                                      .toUpperCase() +
                                                  songDetails[index].last
                                                      .substring(1)
                                            : '_______',
                                        style: context.text.titleLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const Text('Language(s):'),
                      Row(
                        children: [
                          Wrap(
                            children: song.classification.languages
                                .toString()
                                .split(',')
                                .map(
                                  (e) => tag(
                                    e[0].toUpperCase() + e.substring(1),
                                    context,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      AppSpacing.h12,
                      const Text('Genre(s):'),
                      Wrap(
                        children: song.classification.genres
                            .toString()
                            .split(', ')
                            .map(
                              (e) => tag(
                                e[0].toUpperCase() + e.substring(1),
                                context,
                              ),
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
