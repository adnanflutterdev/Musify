import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/feature/song/providers/song_selection_provider.dart';
import 'package:musify/feature/search/presentation/screens/search_tab.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/feature/song/widgets/song_selection_bar.dart';

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
        AppNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        appBar: AppBar(
          backgroundColor: context.colors.background,
          toolbarHeight: 1,
        ),
        body: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: Text('Add Songs')),
              Expanded(child: SearchTab()),
              SongSelectionBar(forPlaylist: true),
            ],
          ),
        ),
      ),
    );
  }
}
