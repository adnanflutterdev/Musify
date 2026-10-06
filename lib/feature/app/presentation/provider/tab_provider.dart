import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/app/data/model/tab_data.dart';

List<TabData> tabItems = [
  TabData(Icons.home_outlined, 'Home'),
  TabData(Icons.search, 'Search'),
  TabData(Icons.queue_music_outlined, 'Playlists'),
  TabData(Icons.account_circle, 'Account'),
];



class TabNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void changeTab(int index) {
    state = index;
  }
}

final tabProvider = NotifierProvider<TabNotifier, int>(() => TabNotifier());
