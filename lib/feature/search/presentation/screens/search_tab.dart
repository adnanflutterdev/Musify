import 'package:flutter/material.dart';
import 'package:musify/feature/search/presentation/widgets/searched_songs.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [Expanded(child: SearchedSongs())]);
  }
}
