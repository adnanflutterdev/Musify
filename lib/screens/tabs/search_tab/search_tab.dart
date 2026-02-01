import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/providers/song_search_provider.dart';
import 'package:musify/widgets/custom_text_form_field.dart';
import 'package:musify/widgets/search_tab_widgets/searched_songs.dart';
import 'package:musify/core/utils/colors.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key,});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final searchedTextNotifier = ref.watch(
              searchedTextProvider.notifier,
            );
           
            return Container(
              color: AppColors.surfaceDark,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10,
                ),
                child: CustomTextFormField(
                  hintText: 'Songs, artists, genre, language and movie',
                  onChanged: (value) => searchedTextNotifier.updateState(value),
                ),
              ),
            );
          },
        ),
        Expanded(child: SearchedSongs()),
      ],
    );
  }
}
