import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

List<Set> tabItems = [
  {Icons.home_outlined, 'Home'},
  {Icons.search, 'Search'},
  {Icons.queue_music_outlined, 'Playlists'},
  {Icons.library_music_outlined, 'Library'},
];

class TabsProviderNotifier extends StateNotifier<int> {
  TabsProviderNotifier() : super(0);

  void changeTab(int index) {
    state = index;
  }
}

final tabProvider = StateNotifierProvider<TabsProviderNotifier, int>(
  (ref) => TabsProviderNotifier(),
);
