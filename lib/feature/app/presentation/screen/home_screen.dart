import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/app_dialogs.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/core/widgets/custom_text_form_field.dart';
import 'package:musify/feature/app/presentation/provider/tab_provider.dart';
import 'package:musify/feature/home/presentation/screens/home_tab.dart';
import 'package:musify/feature/playlist/presentation/screens/create_playlist_screen.dart';
import 'package:musify/feature/playlist/presentation/screens/playlist_tab.dart';
import 'package:musify/feature/search/presentation/screens/search_tab.dart';
import 'package:musify/feature/song/providers/song_search_provider.dart';
import 'package:musify/feature/home/presentation/widget/page_navigation_bar.dart';
import 'package:musify/feature/song/widgets/song_selection_bar.dart';
import 'package:musify/feature/song/widgets/song_track.dart';
import 'package:musify/feature/account/presentation/screens/account_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  late PageController _pageController;

  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const PlaylistTab(),
    const AccountTab(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onPageChanged(int index) {
    ref.read(tabProvider.notifier).changeTab(index);
    if (index == 1) {
      ref.watch(searchedTextProvider.notifier).clearState();
    }
  }

  void _onPop(bool didPop, int tabIndex) {
    if (didPop) return;

    if (tabIndex != 0) {
      ref.read(tabProvider.notifier).changeTab(0);
      _pageController.jumpToPage(0);
    } else {
      AppDialogs.showAttentionDialog(
        context: context,
        dialog: AttentionDialog(
          title: 'Exit app',
          content: 'Are you sure to want to exit',
          actionlabel: 'Exit',
          action: () => SystemNavigator.pop(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int tabIndex = ref.watch(tabProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPop(didPop, tabIndex),
      child: CustomScaffold(
        appBar: _buildAppBar(tabIndex),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: tabs.length,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) => tabs[index],
              ),
            ),
          ],
        ),
        footer: Column(
          children: [
            const SongSelectionBar(),
            const SongTrack(),
            PageNavigationBar(
              tabIndex: tabIndex,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar? _buildAppBar(int tabIndex) {
    switch (tabIndex) {
      case == 0:
        return CustomAppBar(
          buildAppLogo: true,
          title: Text(
            'Musify',
            style: context.text.displayLarge?.copyWith(
              color: context.colors.primary,
              letterSpacing: 1.1,
              fontFamily: 'Serif',
            ),
            textScaler: .noScaling,
          ),
        );
      case == 1:
        return const CustomAppBar(
          hasLeading: false,
          verticalPadding: AppSpacing.h4,
          title: AppTextField(
            suffixIcon: Icons.close,
            prefixIcon: Icons.search,
            hintText: 'Search song, artist, movie, genre, category',
          ),
        );
      case == 2:
        return CustomAppBar(
          hasLeading: false,
          title: Text('My Playlists', style: context.text.displaySmall),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylistScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add_sharp),
          ),
        );
      case == 3:
        return CustomAppBar(
          hasLeading: false,
          title: Text('Account', style: context.text.displaySmall),
          trailing: IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.edit),
          ),
        );
      default:
        return null;
    }
  }
}
