import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';
import 'package:musify/feature/home/presentation/widget/song_card_list.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayedRef = ref.watch(recentlyPlayedProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          AppSpacing.h12,
          AsyncWhen(
            value: recentlyPlayedRef,
            onData: (recentlyPlayed) {
              if (recentlyPlayed.isEmpty) {
                return const Text('No Recently Played Songs');
              }
              final songsIds = recentlyPlayed.map((r) => r.songId).toList();

              return SongCardList(title: 'Recently Played', songsIds: songsIds);
            },
          ),
        ],
      ),
    );
  }
}
