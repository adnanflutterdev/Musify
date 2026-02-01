import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musify/core/services/providers/audio_player_provider.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:musify/core/utils/spacers.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/core/widgets/buttons/favourite_button.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/core/widgets/snack_bars.dart';
import 'package:my_progress_bar/progress_bar.dart';

class SongPlayer extends ConsumerWidget {
  const SongPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songStream = ref.watch(songStreamProvider);
    final audioProvider = ref.watch(audioPlayerProvider);
    double coverImageSize = ScreenSize.width / 1.2;

    List<Map<String, dynamic>> loopModes = [
      {'label': 'Off', 'loopMode': LoopMode.off},
      {'label': 'Loop this song', 'loopMode': LoopMode.one},
      {'label': 'Loop all songs', 'loopMode': LoopMode.all},
    ];
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(backgroundColor: AppColors.surfaceDark, toolbarHeight: 1),
      body: SafeArea(
        child: songStream.when(
          data: (data) {
            MediaItem mediaItem = data.mediaItem!;
            final isPlaying = data.playbackState.playing;
            final currentPosition = data.currentPosition;
            final bufferedPosition = data.bufferedPosition;
            bool isSuffled = data.shuffleStream;
            final loopStream = data.loopStream;

            return Column(
              children: [
                // AppBar
                CustomAppBar(title: doubleText(
                            text1: mediaItem.title,
                            style1: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            text2: mediaItem.artist!,
                            style2: TextStyle(
                              color: AppColors.onSurfaceMedium,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),),
                const Spacer(),
                Center(
                  child: CachedNetworkImage(
                    imageUrl: mediaItem.artUri.toString(),
                    placeholder: (context, url) => Container(
                      width: coverImageSize,
                      height: coverImageSize,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: coverImageSize,
                      height: coverImageSize,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                //
                // Player controls

                // Favourite button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FavouriteButton(
                      songId: mediaItem.extras!['songId'],
                      size: 40,
                    ),
                    w20,
                  ],
                ),
                h20,
                // Duration labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      whiteTextMicro(durationLabel(currentPosition)),
                      const Spacer(),
                      whiteTextMicro(
                        durationLabel(mediaItem.duration!.inSeconds),
                      ),
                    ],
                  ),
                ),
                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: HorizontalProgressBar(
                    trackHeight: 7,
                    thumbDiameter: 16,
                    currentPosition: currentPosition,
                    thumbColor: AppColors.primaryVariant,
                    bufferedPosition: bufferedPosition,
                    bufferedColor: AppColors.surfaceMuted,
                    maxValue: mediaItem.duration!.inSeconds.toDouble(),
                    progressColor: AppColors.primary.withValues(alpha: 0.7),
                    onChanged: (value) {
                      audioProvider.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                h10,
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          showAppSnackbar(
                            context: context,
                            message:
                                'Shuffle mode turned ${isSuffled ? 'off' : 'on'}...',
                          );
                          await audioProvider.changeShuffleMode(!isSuffled);
                        },
                        icon: Icon(
                          Icons.shuffle_sharp,
                          size: 25,
                          color: isSuffled
                              ? AppColors.surfaceWhite
                              : AppColors.surfaceMuted,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          audioProvider.skipToPrevious();
                        },
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          size: 35,
                          color: AppColors.surfaceWhite,
                        ),
                      ),
                      w20,
                      GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            audioProvider.pause();
                          } else {
                            audioProvider.play();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryVariant,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              size: 45,
                              color: AppColors.surfaceWhite,
                            ),
                          ),
                        ),
                      ),
                      w20,
                      IconButton(
                        onPressed: () {
                          audioProvider.skipToNext();
                        },
                        icon: Icon(
                          Icons.skip_next_rounded,
                          size: 35,
                          color: AppColors.surfaceWhite,
                        ),
                      ),
                      const Spacer(),

                      GestureDetector(
                        onTapDown: (details) {
                          final pos = details.globalPosition;
                          showMenu(
                            color: AppColors.surfaceVariant,
                            position: RelativeRect.fromLTRB(
                              pos.dx - 10,
                              pos.dy - 10,
                              0,
                              0,
                            ),
                            context: context,
                            items: loopModes
                                .map(
                                  (loop) => PopupMenuItem(
                                    onTap: () {
                                      audioProvider.loopSongs(loop['loopMode']);
                                    },
                                    child: loopStream == loop['loopMode']
                                        ? primaryTextNormal(loop['label'])
                                        : whiteTextSmall(loop['label']),
                                  ),
                                )
                                .toList(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: 25,
                            height: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  child: Icon(
                                    Icons.loop,
                                    size: 25,
                                    color: loopStream == LoopMode.off
                                        ? AppColors.surfaceMuted
                                        : AppColors.surfaceWhite,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: whiteTextMicro(
                                    loopStream == LoopMode.one
                                        ? '1'
                                        : loopStream == LoopMode.all
                                        ? 'all'
                                        : '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            );
          },
          error: (error, stackTrace) =>
              Center(child: errorText('Error Occured')),
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.surfaceWhite),
          ),
        ),
      ),
    );
  }
}
