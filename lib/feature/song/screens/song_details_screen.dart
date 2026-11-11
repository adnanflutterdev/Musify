import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/extension/size_extention.dart';
import 'package:musify/core/extension/string_extention.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/custom_ink_well.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/feature/listening/presentation/providers/audio_player_provider.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';

class SongDetailsScreen extends StatelessWidget {
  const SongDetailsScreen({super.key, required this.song});
  final Song song;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          // BG Image
          _buildBGImage(),

          // Circle with shadow
          _buildCurve(context),

          // Main Image
          _buildContent(context),

          // Controls
          _buildControls(context),
        ],
      ),
    );
  }

  Widget _buildBGImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CachedNetworkImage(
        imageUrl: song.media.coverImage,
        imageBuilder: (context, imageProvider) {
          return SizedBox(
            width: context.width,
            height: context.width - 2,
            child: Stack(
              children: [
                Container(
                  width: context.width,
                  height: context.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: .cover),
                  ),
                ),
                BackdropFilter(
                  filter: .blur(sigmaX: 3, sigmaY: 0),
                  child: Container(
                    width: context.width,
                    height: context.width,
                    color: context.colors.black.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurve(BuildContext context) {
    return const Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CurvedMusicBackground(),
    );
  }

  Widget _buildContent(BuildContext context) {
    final imageSize = context.width / 1.9;
    final padding = AppSpacing.lg;
    return Positioned(
      top: 50,
      left: padding,
      right: padding,
      child: SizedBox(
        height: context.height - (kToolbarHeight + kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPrimaryImage(context, imageSize),
              _buildTitleSection(context),
              _buildActionButtons(context),
              AppSpacing.h20,
              _buildBasicData(context),
              AppSpacing.h20,
              _buildOtherInfo(context),
              const SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryImage(BuildContext context, double imageSize) {
    return CachedNetworkImage(
      imageUrl: song.media.coverImage,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: context.colors.white),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            image: DecorationImage(image: imageProvider, fit: .cover),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: context.colors.white),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),

            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [context.colors.background, context.colors.surface],
            ),
          ),
        );
      },

      errorWidget: (context, url, error) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: context.colors.white),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),

            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [context.colors.background, context.colors.surface],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colors.black.withValues(alpha: 0.5),
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            song.title,
            maxLines: 2,
            textAlign: .center,
            overflow: .ellipsis,
            textScaler: .noScaling,
            style: context.text.displaySmall?.copyWith(
              fontSize: 22,
              color: context.colors.white,
            ),
          ),
          if (song.getArtists().isNotEmpty)
            Text(
              song.getArtists(),

              style: context.text.bodyLarge?.copyWith(
                color: context.colors.white.withValues(alpha: 0.8),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 15,
      children: [
        _buildSideActionButton(
          context: context,
          icon: Icons.favorite,
          color: context.colors.primaryDark,
          onTap: () {},
        ),
        _buildPlayButton(context: context, song: song),
        _buildSideActionButton(
          context: context,
          icon: Icons.playlist_add_rounded,
          color: context.colors.primary,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPlayButton({required BuildContext context, required Song song}) {
    return Consumer(
      builder: (context, ref, _) {
        final songStream = ref.watch(songStreamProvider);
        final audioProvider = ref.watch(audioPlayerProvider);
        return AsyncWhen(
          value: songStream,
          onData: (data) {
            final mediaItem = data.mediaItem;
            bool isSameSong = mediaItem?.id == song.media.audioUrl;
            bool isPlaying = isSameSong && data.playbackState.playing;

            return CustomInkWell(
              onTap: () {
                if (!isSameSong) {
                  MediaItem item = MediaItem(
                    id: song.media.audioUrl,
                    title: song.title,
                    artUri: Uri.parse(song.media.coverImage),
                    artist: song.getArtists(),
                    duration: Duration(seconds: song.media.duration),
                    extras: {'songId': song.id},
                  );
                  audioProvider.playSong(item);
                } else if (isPlaying) {
                  audioProvider.pause();
                } else {
                  audioProvider.play();
                }
              },
              splashColor: context.colors.primary,
              isCircular: true,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: .circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colors.primary,
                      context.colors.primaryDark,
                    ],
                  ),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,

                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.7,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },

                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      key: ValueKey<bool>(isPlaying),
                      color: context.colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSideActionButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CustomInkWell(
      onTap: onTap,
      isCircular: true,
      borderSide: BorderSide(color: context.colors.primaryLight),
      child: Ink(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              context.colors.background,
              context.colors.primary.withValues(alpha: 0.3),
            ],
            radius: 1.7,
          ),
          shape: .circle,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Icon(icon, color: color, size: 25),
      ),
    );
  }

  Widget _buildBasicData(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.6),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomLeft,
            colors: [
              context.colors.primary.withValues(alpha: 0.25),
              context.colors.primary.withValues(alpha: 0.03),
            ],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            if (song.release.releaseDate != null) ...[
              _buildDataSection(
                context: context,
                flex: 3,
                icon: Icons.calendar_month_outlined,
                title: 'Released',
                content: DateFormat.yMMMd().format(song.release.releaseDate!),
              ),
              _buildVerticalDivider(context),
            ] else ...[
              _buildDataSection(
                context: context,
                flex: song.release.type == 'single' ? 2 : 3,
                icon: Icons.album_outlined,
                title: 'Format',
                content: song.release.type.capitalize,
              ),
              _buildVerticalDivider(context),
            ],
            ...[
              _buildDataSection(
                context: context,
                flex: 2,
                icon: Icons.watch_later_outlined,
                title: 'Duration',
                content: durationLabel(song.media.duration),
              ),
              _buildVerticalDivider(context),
            ],
            _buildDataSection(
              context: context,
              flex: 2,
              icon: Icons.headphones_rounded,
              title: 'Listens',
              content: song.stats.playCount.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSection({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Column(
        // crossAxisAlignment: .start,
        children: [
          Icon(icon, size: 30, color: context.colors.primary),
          Text(
            title,
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          Text(content, style: context.text.bodyLarge, maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        width: 1,
        height: 70,
        color: context.colors.primary.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildOtherInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.6),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),

      child: Container(
        decoration: BoxDecoration(
          color: context.colors.primaryDark.withValues(alpha: 0.06),

          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Column(
          children: [
            if (song.context.movie != null || song.album != null) ...[
              _buildOtherInfoSection(
                context: context,
                title: 'From',
                icon: Icons.person_outline,
                haveMultipleSymbol: false,
                content: song.context.movie?.name ?? song.album!.name,
              ),
              _buildDivider(context),
            ],
            if (song.classification.languages.isNotEmpty) ...[
              _buildOtherInfoSection(
                context: context,
                icon: Icons.translate,
                title: 'Languages',
                content: song.classification.languages,
              ),
              _buildDivider(context),
            ],
            if (song.classification.genres.isNotEmpty) ...[
              _buildOtherInfoSection(
                context: context,
                icon: Icons.music_note_rounded,
                title: 'Genre',
                content: song.classification.genres,
              ),
              _buildDivider(context),
            ],
            if (song.classification.moods.isNotEmpty) ...[
              _buildOtherInfoSection(
                context: context,
                icon: Icons.mood_outlined,
                title: 'Moods',
                content: song.classification.moods,
              ),
              _buildDivider(context),
            ],
            if (song.classification.tags.isNotEmpty) ...[
              _buildOtherInfoSection(
                context: context,
                icon: Icons.sell_outlined,
                title: 'Tags',
                content: song.classification.tags,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(),
    );
  }

  Widget _buildOtherInfoSection({
    required BuildContext context,
    required IconData icon,
    required String title,
    required dynamic content,
    bool haveMultipleSymbol = true,
  }) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: .circle,
            gradient: LinearGradient(
              colors: [
                context.colors.primaryDark.withValues(alpha: 0.4),
                context.colors.primaryDark.withValues(alpha: 0.6),
              ],
            ),
            // boxShadow: [AppShadow.shadowLvl1(context, blurRadius: 1)],
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Icon(
            icon,
            size: 30,
            color: context.colors.white,
            shadows: [AppShadow.shadowLvl1(context)],
          ),
        ),
        AppSpacing.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                crossAxisAlignment: .start,
                children: [
                  Text(title, style: context.text.bodyLarge),
                  if (haveMultipleSymbol)
                    Transform.translate(
                      offset: const Offset(-2, -1),
                      child: Text(
                        '﹙s﹚',
                        style: context.text.bodyLarge?.copyWith(
                          letterSpacing: -6,
                        ),
                      ),
                    ),
                ],
              ),
              if (content is String)
                Text(content)
              else if (content is List<String>)
                Wrap(
                  spacing: AppSpacing.sm,
                  children: List.generate(content.length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colors.primaryDark.withValues(alpha: 0.4),
                            context.colors.primaryDark.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLg,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      child: Text(
                        content[index].toUpperCase(),
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls(BuildContext context) {
    return Positioned(
      top: 40,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: Row(
        children: [
          _buildButton(
            context: context,
            icon: Icons.arrow_back,
            onTap: () {
              AppNavigator.pop();
            },
          ),
          const Spacer(),

          // _buildButton(
          //   context: context,
          //   icon: Icons.favorite,
          //   iconColor: context.colors.primaryDark,
          //   onTap: () {},
          // ),
          // AppSpacing.w12,
          _buildButton(context: context, icon: Icons.more_vert, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return CustomInkWell(
      onTap: onTap,
      splashColor: context.colors.background,
      backgroudColor: context.colors.black.withValues(alpha: 0.4),
      isCircular: true,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, color: iconColor ?? context.colors.white),
      ),
    );
  }
}

class CurvedMusicBackground extends StatelessWidget {
  const CurvedMusicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvedMusicPainter(context),
      child: SizedBox(width: context.width, height: context.height),
    );
  }
}

class _CurvedMusicPainter extends CustomPainter {
  final BuildContext context;
  _CurvedMusicPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.width;

    // Curve separating the upper and lower backgrounds.
    final curve = Path()
      ..moveTo(0, height * 0.8)
      ..quadraticBezierTo(width / 1.5, height, width, height * 0.6);

    // Closing the path with line so it will make a closed shape
    final background = Path.from(curve)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    // Paint to fill the background
    Paint curvePaint = Paint()
      ..color = context.colors.background
      ..style = .fill;

    canvas.drawPath(background, curvePaint);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = context.colors.primary
      ..strokeWidth = 12
      ..shader = LinearGradient(
        colors: [
          context.colors.primaryDark,
          context.colors.primary,
          context.colors.background,
          context.colors.primary,
          context.colors.primaryDark,
        ],
        // stops: [0.35, 0.55, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawPath(curve, glowPaint);

    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..shader = LinearGradient(
        colors: [
          context.colors.primaryDark,
          context.colors.primary,
          context.colors.primaryDark,
        ],

        stops: [0.35, 0.55, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawPath(curve, edgePaint);
  }

  @override
  bool shouldRepaint(covariant _CurvedMusicPainter oldDelegate) {
    return true;
  }
}
