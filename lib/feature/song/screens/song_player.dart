import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/feature/listening/presentation/providers/audio_player_provider.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';

import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/screen_size.dart';

import 'package:musify/core/widgets/buttons/favourite_button.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
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
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        toolbarHeight: 1,
      ),
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
                CustomAppBar(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: mediaItem.title,
                          style: context.text.headlineMedium,
                        ),
                        TextSpan(
                          text: mediaItem.artist!,
                          style: context.text.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: CachedNetworkImage(
                    imageUrl: mediaItem.artUri.toString(),
                    placeholder: (context, url) => Container(
                      width: coverImageSize,
                      height: coverImageSize,
                      decoration: BoxDecoration(
                        color: context.colors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: coverImageSize,
                      height: coverImageSize,
                      decoration: BoxDecoration(
                        color: context.colors.background,
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
                    AppSpacing.w20,
                  ],
                ),
                AppSpacing.h20,
                // Duration labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        durationLabel(currentPosition.toInt()),
                        style: context.text.labelSmall,
                      ),
                      const Spacer(),
                      Text(
                        durationLabel(mediaItem.duration!.inSeconds),
                        style: context.text.labelSmall,
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
                    thumbColor: context.colors.primaryDark,
                    bufferedPosition: bufferedPosition,
                    bufferedColor: context.colors.disabled,
                    maxValue: mediaItem.duration!.inSeconds.toDouble(),
                    progressColor: context.colors.primary.withValues(
                      alpha: 0.7,
                    ),
                    onChanged: (value) {
                      audioProvider.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                AppSpacing.h12,
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          // showAppSnackbar(
                          //   context: context,
                          //   message:
                          //       'Shuffle mode turned ${isSuffled ? 'off' : 'on'}...',
                          // );
                          await audioProvider.changeShuffleMode(!isSuffled);
                        },
                        icon: Icon(
                          Icons.shuffle_sharp,
                          size: 25,
                          color: isSuffled ? null : context.colors.disabled,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          audioProvider.skipToPrevious();
                        },
                        icon: const Icon(Icons.skip_previous_rounded, size: 35),
                      ),
                      AppSpacing.w20,
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
                            color: context.colors.primaryDark,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.w20,
                      IconButton(
                        onPressed: () {
                          audioProvider.skipToNext();
                        },
                        icon: const Icon(Icons.skip_next_rounded, size: 35),
                      ),
                      const Spacer(),

                      GestureDetector(
                        onTapDown: (details) {
                          final pos = details.globalPosition;
                          showMenu(
                            color: context.colors.surfaceVariant,
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
                                        ? Text(
                                            loop['label'],
                                            style: context.text.bodyMedium
                                                ?.copyWith(
                                                  color: context.colors.primary,
                                                ),
                                          )
                                        : Text(loop['label']),
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
                                        ? context.colors.disabled
                                        : null,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text(
                                    loopStream == LoopMode.one
                                        ? '1'
                                        : loopStream == LoopMode.all
                                        ? 'all'
                                        : '',
                                    style: context.text.labelSmall,
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
              const Center(child: Text('Error Occured')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
