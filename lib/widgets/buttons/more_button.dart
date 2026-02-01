import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/providers/user_data_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:musify/core/utils/spacers.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/widgets/buttons/custom_button.dart';
import 'package:musify/widgets/custom_text_form_field.dart';
import 'package:musify/widgets/snack_bars.dart';

class MoreButton extends ConsumerWidget {
  const MoreButton({
    super.key,
    required this.canAddSongs,
    required this.editable,
    required this.title,
  });
  final bool canAddSongs;
  final bool editable;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPlaylists =
        ref.watch(userDataProvider).value?.myPlaylists ?? [];
    void changeName() {
      final TextEditingController controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                whiteTextSmall('Enter new name'),
                h5,
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
                      showAppSnackbar(
                        context: context,
                        message: 'Name updated...',
                        snackBarType: SnackBarType.success,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } on FirebaseException catch (_) {
                      if (!context.mounted) {
                        return;
                      }
                      showAppSnackbar(
                        context: context,
                        message: 'Error occured',
                        snackBarType: SnackBarType.error,
                      );
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

    return GestureDetector(
      onTapDown: (details) {
        final dx = details.globalPosition.dx;
        final dy = details.globalPosition.dy;

        showMenu(
          context: context,
          color: AppColors.surface,

          menuPadding: EdgeInsets.all(5),
          position: RelativeRect.fromLTRB(
            dx,
            dy,
            ScreenSize.width - dx,
            ScreenSize.height - dy,
          ),
          items: [
            if (editable)
              PopupMenuItem(
                height: 40,
                padding: EdgeInsets.all(0),
                onTap: changeName,
                child: Center(child: whiteTextSmall('Edit name')),
              ),

            if (canAddSongs)
              PopupMenuItem(
                padding: EdgeInsets.all(0),
                height: 40,

                child: Center(child: whiteTextSmall('Add songs')),
              ),
            if (editable)
              PopupMenuItem(
                padding: EdgeInsets.all(0),
                height: 40,
                child: Center(child: whiteTextSmall('Remove songs')),
              ),
          ],
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surfaceVariant,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Icon(Icons.more_vert, color: AppColors.surfaceWhite, size: 25),
        ),
      ),
    );
  }
}
