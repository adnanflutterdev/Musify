import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/providers/song_search_provider.dart';
import 'package:musify/widgets/search_tab_widgets/searched_songs.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/text_field_borders.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final searchedTextNotifier = ref.watch(
                searchedTextProvider.notifier,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5,
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.surfaceWhite,
                  style: TextStyle(color: AppColors.surfaceWhite),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Search song',
                    fillColor: AppColors.surfaceLight,
                    hintStyle: TextStyle(color: AppColors.onSurfaceLow),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),

                    // Enabled Border
                    enabledBorder: outlinedBorder(
                      color: AppColors.surfaceWhite,
                      width: 0.5,
                    ),
                    // Focused Border
                    focusedBorder: outlinedBorder(
                      color: AppColors.primaryVariant,
                      width: 2.0,
                    ),
                  ),
                  onChanged: (value) => searchedTextNotifier.updateState(value),
                ),
              );
            },
          ),
          Expanded(child: SearchedSongs()),
        ],
      ),
    );
  }
}
