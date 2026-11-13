import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/custom_ink_well.dart';
import 'package:musify/core/widgets/song_list_loader.dart';
import 'package:musify/feature/playlist/presentation/screens/playlist_screen.dart';
import 'package:musify/feature/song/providers/songs_provider.dart';
import 'package:musify/feature/song/screens/song_details_screen.dart';

class SongList extends ConsumerWidget {
  const SongList({super.key, required this.title, required this.songsIds});
  final String title;
  final List<String> songsIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsRef = ref.watch(songsByIdsProvider(songsIds));
    return AsyncWhen(
      value: songsRef,
      loader: const SongListLoader(),
      onData: (songs) {
        if (songs.isEmpty) {
          return const SizedBox.shrink();
        }
        final imageSize = 110.0;
        final verticalPadding = AppSpacing.xs;
        final textStyle =
            context.text.bodyMedium ?? const TextStyle(fontSize: 14);

        final textScaler = MediaQuery.textScalerOf(context);
        final lineHeight = textStyle.height ?? 1.2;
        final textHeight =
            textScaler.scale(textStyle.fontSize!) * lineHeight * 2;

        final boxHeight = imageSize + 4 + textHeight + (verticalPadding * 4);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(title, style: context.text.headlineLarge),
                  ),
                  TextButton(
                    onPressed: () {
                      AppNavigator.push(
                        PlaylistScreen(title: title, songs: songs),
                      );
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              Container(
                height: boxHeight,
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  boxShadow: [AppShadow.shadowLvl1(context)],
                ),
                padding: EdgeInsets.all(verticalPadding),
                child: ListView.separated(
                  scrollDirection: .horizontal,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];

                    return CustomInkWell(
                      onTap: () =>
                          AppNavigator.push(SongDetailsScreen(song: song)),
                      splashColor: context.colors.selection,

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: verticalPadding,
                        ),
                        child: SizedBox(
                          width: imageSize,
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              _buildImage(song.media.coverImage, imageSize),
                              AppSpacing.h4,
                              Text(
                                '${song.title}${song.getArtists().isNotEmpty ? ' - ' : ''}${song.getArtists()}',
                                maxLines: 2,
                                overflow: .ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.w4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(String url, size) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            image: DecorationImage(image: imageProvider),
          ),
          clipBehavior: .antiAlias,
        );
      },

      placeholder: (context, url) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            image: DecorationImage(image: AssetImage(AppImages.coverImage)),
          ),
          clipBehavior: .antiAlias,
        );
      },

      errorWidget: (context, url, error) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            image: DecorationImage(image: AssetImage(AppImages.coverImage)),
          ),
          clipBehavior: .antiAlias,
        );
      },
    );
  }
}
