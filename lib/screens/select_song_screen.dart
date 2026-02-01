import 'package:flutter/material.dart';
import 'package:musify/core/services/providers/song_selection_provider.dart';
import 'package:musify/screens/tabs/search_tab/search_tab.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/widgets/custom_app_bar.dart';
import 'package:musify/widgets/song_selection_bar.dart';

class SelectSongScreen extends StatelessWidget {
  const SelectSongScreen({
    super.key,
    required this.turnOnOffSongSelectionNotifier,
  });
  final TurnOnOffSongSelectionNotifier turnOnOffSongSelectionNotifier;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        turnOnOffSongSelectionNotifier.stop();
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark,
          toolbarHeight: 1,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: appBarText('Add Songs')),
              Expanded(child: SearchTab()),
              SongSelectionBar(forPlaylist: true),
            ],
          ),
        ),
      ),
    );
  }
}
