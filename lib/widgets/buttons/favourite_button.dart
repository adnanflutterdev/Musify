import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/providers/user_data_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/widgets/snack_bars.dart';

class FavouriteButton extends ConsumerWidget {
  const FavouriteButton({super.key, required this.songId, this.size});
  final double? size;
  final String songId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteSongs = ref.watch(userDataProvider).value!.favouriteSongs;
    bool isFavourite = favouriteSongs.contains(songId);
    return GestureDetector(
      onTap: () async {
        try {
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
                'favourite': isFavourite
                    ? FieldValue.arrayRemove([songId])
                    : FieldValue.arrayUnion([songId]),
              });
          if (!context.mounted) {
            return;
          }
          showAppSnackbar(
            context: context,
            message: isFavourite
                ? 'Song removed from favourite songs playlist...'
                : 'Song added to favourite songs playlist...',
            snackBarType: isFavourite
                ? SnackBarType.normal
                : SnackBarType.success,
          );
        } on FirebaseException catch (err) {
          if (!context.mounted) {
            return;
          }
          showAppSnackbar(
            context: context,
            message: err.toString(),
            snackBarType: SnackBarType.error,
          );
        }
      },
      child: Container(
        width: size ?? 30,
        height: size ?? 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFavourite
              ? AppColors.surfaceVariant
              : AppColors.surfaceLight,
        ),
        child: Icon(
          isFavourite ? Icons.favorite_rounded : Icons.favorite_outline_sharp,
          color: isFavourite
              ? AppColors.primaryVariant
              : AppColors.surfaceWhite,
          size: size == null ? 18 : (size! - 15),
        ),
      ),
    );
  }
}
