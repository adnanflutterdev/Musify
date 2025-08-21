import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/screens/select_song_screen.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/song_selection_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/buttons/custom_button.dart';
import 'package:musify/widgets/custom_app_bar.dart';
import 'package:musify/widgets/custom_text_form_field.dart';
import 'package:musify/widgets/snack_bars.dart';

class CreatePlaylistScreen extends ConsumerStatefulWidget {
  const CreatePlaylistScreen({super.key});

  @override
  ConsumerState<CreatePlaylistScreen> createState() =>
      _CreatePlaylistScreenState();
}

class _CreatePlaylistScreenState extends ConsumerState<CreatePlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> createPlaylist({required List<String> songIds}) async {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        await FirebaseFirestore.instance
            .collection('userData')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
              'myPlaylists': FieldValue.arrayUnion([
                {'title': _controller.text.trim(), 'songIds': songIds},
              ]),
            });
        if (!mounted) {
          return;
        }
        showAppSnackbar(
          context: context,
          message: 'Playlist created successfully',
          snackBarType: SnackBarType.success,
        );
      } on FirebaseException catch (_) {
        if (!mounted) {
          return;
        }
        showAppSnackbar(
          context: context,
          message: 'Failed to create playlist',
          snackBarType: SnackBarType.error,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final turnOnOffSongSelectionNotifier = ref.watch(
      turnOnOffSongSelectionProvider.notifier,
    );
    final songSelectionNotifer = ref.watch(songSelectionProvider.notifier);
    final selectedSongs = ref.watch(songSelectionProvider);
    List<Song> addedSongs = selectedSongs.songsOrder
        .map((songId) => selectedSongs.selectedSongs[songId])
        .whereType<Song>()
        .toList();
    //

    void clearProvider() {
      turnOnOffSongSelectionNotifier.stop();
      songSelectionNotifer.clear();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        clearProvider();
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: AppColors.surfaceDark,
        ),
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: appBarText('Create playlist'),
                extraPopFunction: clearProvider,
              ),
              h10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: whiteTextSmall('Enter playlist name'),
              ),
              h5,
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomTextFormField(
                    hintText: 'Playlist name',
                    controller: _controller,
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                child: Row(
                  children: [
                    whiteTextSmall('Songs'),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        turnOnOffSongSelectionNotifier.start();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectSongScreen(
                              turnOnOffSongSelectionNotifier:
                                  turnOnOffSongSelectionNotifier,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: AppColors.surfaceMuted),
                    ),
                  ],
                ),
              ),
              h10,
              Expanded(
                child: Stack(
                  children: [
                    addedSongs.isEmpty
                        ? Center(child: whiteTextSmall('No songs added'))
                        : ListView.builder(
                            itemCount: addedSongs.length,
                            itemBuilder: (context, index) {
                              Song song = addedSongs[index];
                              return ListTile(
                                minTileHeight: 50,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 3.0,
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: song.coverImage,
                                  placeholder: (context, url) => CircleAvatar(
                                    radius: 23,
                                    backgroundImage: AssetImage(coverImage),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        radius: 23,
                                        backgroundImage: AssetImage(coverImage),
                                      ),
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 23,
                                        backgroundImage: imageProvider,
                                      ),
                                ),
                                title: tileTitle(song.songName),
                                subtitle: tileSubTitle(song.artistName),
                                trailing: IconButton(
                                  onPressed: () {
                                    songSelectionNotifer.toggleSongSelection(
                                      song,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: AppColors.surfaceMuted,
                                  ),
                                ),
                              );
                            },
                          ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CustomTextButton(
                        onPressed: () async {
                          await createPlaylist(
                            songIds: selectedSongs.songsOrder,
                          );
                          clearProvider();
                          if (!context.mounted) {
                            return;
                          }
                          Navigator.pop(context);
                        },
                        title: 'Create',
                      ),
                    ),
                  ],
                ),
              ),

              h20,
            ],
          ),
        ),
      ),
    );
  }
}
