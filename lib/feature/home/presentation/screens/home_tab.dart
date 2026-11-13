import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/song_list_loader.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';
import 'package:musify/feature/home/presentation/widget/song_list.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayedRef = ref.watch(recentlyPlayedProvider);
    final favouriteSongsRef = ref.watch(favouriteSongsProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          AppSpacing.h12,
          AsyncWhen(
            value: recentlyPlayedRef,
            loader: const SongListLoader(),
            onData: (recentlyPlayed) {
              if (recentlyPlayed.isEmpty) {
                return const SizedBox.shrink();
              }
              final songsIds = recentlyPlayed.map((r) => r.songId).toList();

              return SongList(title: 'Recently Played', songsIds: songsIds);
            },
          ),

          AppSpacing.h12,

          AsyncWhen(
            value: favouriteSongsRef,
            loader: const SongListLoader(),
            onData: (favouriteSongs) {
              if (favouriteSongs.isEmpty) {
                return const SizedBox.shrink();
              }
              final songsIds = favouriteSongs.map((r) => r.songId).toList();

              return SongList(title: 'Favourite Songs', songsIds: songsIds);
            },
          ),
        ],
      ),
    );
  }
}
