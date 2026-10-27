import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/feature/song/providers/songs_provider.dart';

class SongCardList extends ConsumerWidget {
  const SongCardList({super.key, required this.title, required this.songsIds});
  final String title;
  final List<String> songsIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsRef = ref.watch(songsByIdsProvider(songsIds));
    return AsyncWhen(
      value: songsRef,
      onData: (songs) {
        if (songs.isEmpty) {
          return const SizedBox.shrink();
        }
        final imageSize = 110.0;
        final verticalPadding = AppSpacing.md;
        final fontSize = context.text.bodyMedium?.fontSize ?? 14;
        final boxHeight =
            imageSize +
            (verticalPadding * 2) +
            (MediaQuery.of(context).textScaler.scale(fontSize) * 2);
        return Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: context.text.headlineLarge)),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: SizedBox(
                height: boxHeight - 3.5, // -3.5 used to adjust some default space left due to text
                child: ListView.separated(
                  scrollDirection: .horizontal,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return SizedBox(
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
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.w16,
                ),
              ),
            ),
          ],
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
