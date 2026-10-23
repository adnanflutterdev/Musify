import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    // List<PopupMenuItem> recentlyPlayedMenuItems = [
    //   PopupMenuItem(
    //     height: 40,
    //     padding: const EdgeInsets.all(0),
    //     onTap: () {
    //       ref.read(turnOnOffSongSelectionProvider.notifier).start();
    //     },
    //     child: Center(
    //       child: Text('Remove songs', style: context.text.bodySmall),
    //     ),
    //   ),
    //   PopupMenuItem(
    //     height: 40,
    //     padding: const EdgeInsets.all(0),
    //     onTap: () {
    //       showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: Text(
    //               'Clear History',
    //               style: context.text.bodyLarge?.copyWith(
    //                 color: AppColors.onError,
    //               ),
    //             ),
    //             content: Text(
    //               'Are you sure to delete all recently played songs?',
    //               style: context.text.bodySmall,
    //             ),
    //             actions: [
    //               TextButton(
    //                 onPressed: () async {
    //                   await FirebaseFirestore.instance
    //                       .collection('userData')
    //                       .doc(FirebaseAuth.instance.currentUser?.uid)
    //                       .update({'recentlyPlayed': []});
    //                   if (context.mounted) {
    //                     AppNavigator.pop();
    //                   }
    //                 },
    //                 child: Text(
    //                   'ok',
    //                   style: context.text.bodySmall?.copyWith(
    //                     color: AppColors.onError,
    //                   ),
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed: () {
    //                   AppNavigator.pop();
    //                 },
    //                 child: Text('Cancel', style: context.text.bodySmall),
    //               ),
    //             ],
    //           );
    //         },
    //       );
    //     },
    //     child: Center(
    //       child: Text('Clear History', style: context.text.bodySmall),
    //     ),
    //   ),
    // ];
    return const SingleChildScrollView(child: Column(children: [
        ],
      ));
  }
}
