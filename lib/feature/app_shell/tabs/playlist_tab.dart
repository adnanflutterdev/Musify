import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/widgets/buttons/custom_button.dart';
import 'package:musify/core/widgets/custom_text_form_field.dart';
import 'package:musify/feature/playlist/create_playlist_screen.dart';
import 'package:musify/core/services/providers/playlist_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/feature/home/widget/song_list.dart';

class PlaylistTab extends ConsumerWidget {
  const PlaylistTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPlaylists = [];
    // final myPlaylists = ref.watch(userDataProvider).value?.myPlaylists ?? [];

    void push() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreatePlaylistScreen()),
      );
    }

    void changeName(String title) {
      final TextEditingController controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter new name, style: context.textTheme.bodySmall',
                ),
                AppSpacing.h4,
                Form(
                  key: formKey,
                  child: CustomTextFormField(
                    hintText: 'New name',
                    controller: controller,
                    errorBorder: true,
                    focusedErorBorder: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter name of playlist';
                      } else if (value.length < 3) {
                        return 'playist name length must be greater than 3';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            actions: [
              CustomTextButton(
                onPressed: () async {
                  bool isValid = formKey.currentState!.validate();
                  if (isValid) {
                    List playlist = myPlaylists;
                    int index = playlist.indexWhere(
                      (map) => map['title'] == title,
                    );
                    playlist[index]['title'] = controller.text.trim();
                    try {
                      await FirebaseFirestore.instance
                          .collection('userData')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'myPlaylists': playlist});
                      if (!context.mounted) {
                        return;
                      }
                      // showAppSnackbar(
                      //   context: context,
                      //   message: 'Name updated...',
                      //   snackBarType: SnackBarType.success,
                      // );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } on FirebaseException catch (_) {
                      if (!context.mounted) {
                        return;
                      }
                      // showAppSnackbar(
                      //   context: context,
                      //   message: 'Error occured',
                      //   snackBarType: SnackBarType.error,
                      // );
                    }
                  }
                },
                title: 'Update',
              ),
            ],
          );
        },
      );
    }

    void deletePlaylistDialog(String title) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Deleting Playlist',
              style: context.text.bodyLarge?.copyWith(color: AppColors.onError),
            ),
            content: Text(
              'Are you sure to delete this playlist?',
              style: context.text.bodySmall,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  // await FirebaseFirestore.instance
                  //     .collection('userData')
                  //     .doc(FirebaseAuth.instance.currentUser?.uid)
                  //     .update({'recentlyPlayed': []});
                  // if (context.mounted) {
                  //   Navigator.pop(context);
                  // }
                  List playlist = myPlaylists;
                  int index = playlist.indexWhere(
                    (map) => map['title'] == title,
                  );
                  playlist.removeAt(index);
                  try {
                    await FirebaseFirestore.instance
                        .collection('userData')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({'myPlaylists': playlist});
                    if (!context.mounted) {
                      return;
                    }
                    // showAppSnackbar(
                    //   context: context,
                    //   message: 'Playlist Deleted...',
                    //   snackBarType: SnackBarType.success,
                    // );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } on FirebaseException catch (_) {
                    if (!context.mounted) {
                      return;
                    }
                    // showAppSnackbar(
                    //   context: context,
                    //   message: 'Error occured',
                    //   snackBarType: SnackBarType.error,
                    // );
                  }
                },
                child: Text(
                  'Delete',
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
    }

    List<PopupMenuItem> menuItems(String title) => [
      PopupMenuItem(
        height: 40,
        padding: const EdgeInsets.all(0),
        onTap: () => changeName(title),
        child: Center(child: Text('Edit name', style: context.text.bodySmall)),
      ),

      PopupMenuItem(
        padding: const EdgeInsets.all(0),
        height: 40,

        child: Center(child: Text('Add songs', style: context.text.bodySmall)),
      ),

      PopupMenuItem(
        padding: const EdgeInsets.all(0),
        height: 40,
        child: Center(
          child: Text('Remove songs', style: context.text.bodySmall),
        ),
      ),
      PopupMenuItem(
        padding: const EdgeInsets.all(0),
        height: 40,
        onTap: () => deletePlaylistDialog(title),
        child: Center(
          child: Text(
            'Delete Playlist',
            style: context.text.bodySmall!.copyWith(color: AppColors.onError),
          ),
        ),
      ),
    ];

    final playlists = ref.watch(playlistProvider);

    return Column(
      children: [
        CustomAppBar(
          title: appBarText('My Playlists'),
          hasLeading: false,
          trailing: IconButton(
            onPressed: push,
            icon: const Icon(Icons.add_sharp, color: AppColors.surfaceWhite),
          ),
        ),
        if (playlists.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return SongList(
                  title: playlist['title'],
                  songs: playlist['songs'],
                  menuItems: menuItems(playlist['title']),
                );
              },
            ),
          ),
        if (playlists.isEmpty)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No playlists, style: context.textTheme.bodySmall'),
                TextButton(
                  onPressed: push,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.surfaceVariant,
                  ),
                  child: const Text(
                    'Create playlist, style: context.textTheme.bodySmall',
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
