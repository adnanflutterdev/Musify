import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/feature/song/screens/song_player.dart';
import 'package:musify/feature/listening/presentation/providers/audio_player_provider.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';

import 'package:my_progress_bar/my_progress_bar.dart';

class SongTrack extends ConsumerWidget {
  const SongTrack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songStream = ref.watch(songStreamProvider);
    final audioProvider = ref.watch(audioPlayerProvider);
    return songStream.whenOrNull(
          data: (data) {
            final mediaItem = data.mediaItem;
            final isPlaying = data.playbackState.playing;
            final currentPosition = data.currentPosition;
            final bufferedPosition = data.bufferedPosition;

            return mediaItem == null
                ? const SizedBox.shrink()
                : Container(
                    decoration:  BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: context.colors.disabled,
                          width: 0.7,
                        ),
                      ),
                    ),
                    child: Material(
                      color: context.colors.background,
                      child: ListTile(
                        minTileHeight: 45,
                        minVerticalPadding: 3,
                        horizontalTitleGap: 10,
                        onTap: () => AppNavigator.push(const SongPlayer()),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        leading: CachedNetworkImage(
                          imageUrl: mediaItem.artUri.toString(),
                          placeholder: (context, url) =>  CircleAvatar(
                            radius: 22,
                            backgroundColor: context.colors.surface,
                          ),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: imageProvider,
                              ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(mediaItem.title),
                        ),
                        subtitle: HorizontalProgressBar(
                          maxValue: mediaItem.duration!.inSeconds.toDouble(),
                          currentPosition: currentPosition,
                          progressColor: context.colors.primary.withValues(
                            alpha: 0.7,
                          ),
                          bufferedColor: context.colors.disabled,
                          bufferedPosition: bufferedPosition,
                          thumbColor: context.colors.primaryDark,
                          trackHeight: 4,
                          thumbDiameter: 12,
                          onChanged: (value) {
                            audioProvider.seek(
                              Duration(seconds: value.toInt()),
                            );
                          },
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            if (isPlaying) {
                              audioProvider.pause();
                            } else {
                              audioProvider.play();
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colors.primaryDark,
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
          error: (error, stackTrace) => Container(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ) ??
        Container();
  }
}
