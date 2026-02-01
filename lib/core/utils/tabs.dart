import 'package:flutter/material.dart';
import 'package:musify/feature/app_shell/tabs/home_tab.dart';
import 'package:musify/feature/app_shell/tabs/library_tab.dart';
import 'package:musify/feature/app_shell/tabs/playlist_tab.dart';
import 'package:musify/feature/app_shell/tabs/search_tab.dart';

List<Widget> tabs = [HomeTab(), SearchTab(), PlaylistTab(), LibraryTab()];
