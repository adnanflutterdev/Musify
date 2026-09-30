import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/feature/song/providers/song_selection_provider.dart';
import 'package:musify/feature/song/providers/songs_provider.dart';
import 'package:musify/feature/home/widget/song_list.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> recentlyPlayedMenuItems = [
      PopupMenuItem(
        height: 40,
        padding: const EdgeInsets.all(0),
        onTap: () {
          ref.read(turnOnOffSongSelectionProvider.notifier).start();
        },
        child: Center(
          child: Text('Remove songs', style: context.text.bodySmall),
        ),
      ),
      PopupMenuItem(
        height: 40,
        padding: const EdgeInsets.all(0),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Clear History',
                  style: context.text.bodyLarge?.copyWith(
                    color: AppColors.onError,
                  ),
                ),
                content: Text(
                  'Are you sure to delete all recently played songs?',
                  style: context.text.bodySmall,
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('userData')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({'recentlyPlayed': []});
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'ok',
                      style: context.text.bodySmall?.copyWith(
                        color: AppColors.onError,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: context.text.bodySmall),
                  ),
                ],
              );
            },
          );
        },
        child: Center(
          child: Text('Clear History', style: context.text.bodySmall),
        ),
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final top20SongsList = ref.watch(top20Songs);
              return top20SongsList.when(
                error: (error, stackTrace) => Container(),
                loading: () => Container(),
                data: (data) => SongList(title: 'Top 20 Songs', songs: data),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return SongList(
                title: 'Recently Played',
                songs: ref.watch(recentlyPlayedSongsProvider),
                menuItems: recentlyPlayedMenuItems,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return SongList(
                title: 'Favourite Songs',
                songs: ref.watch(favouriteSongsProvider),
              );
            },
          ),
        ],
      ),
    );
  }
}
