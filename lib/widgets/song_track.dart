import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/screens/song_player.dart';
import 'package:musify/services/providers/audio_player_provider.dart';
import 'package:musify/services/providers/song_stream_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/text.dart';
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
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.musicTrackBackground,
                        border: BoxBorder.all(
                          color: AppColors.primaryPink.withValues(alpha: 0.7),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        minTileHeight: 40,
                        minVerticalPadding: 3,
                        horizontalTitleGap: 10,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SongPlayer()),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        leading: CachedNetworkImage(
                          imageUrl: mediaItem.artUri.toString(),
                          placeholder: (context, url) => CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primaryBackground,
                          ),
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: imageProvider,
                              ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: tileTitle(mediaItem.title),
                        ),
                        subtitle: HorizontalProgressBar(
                          maxValue: mediaItem.duration!.inSeconds.toDouble(),
                          currentPosition: currentPosition,
                          progressColor: AppColors.primaryPink.withValues(
                            alpha: 0.7,
                          ),
                          bufferedColor: AppColors.bufferColor,
                          bufferedPosition: bufferedPosition,
                          thumbColor: AppColors.buttonPink,
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.buttonPink,
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Center(child: CircularProgressIndicator()),
        ) ??
        Container();
  }
}
