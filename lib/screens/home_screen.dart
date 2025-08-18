import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/functions/auth_functions.dart';
import 'package:musify/services/providers/song_search_provider.dart';
import 'package:musify/services/providers/tabs_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/tabs.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/page_navigation_bar.dart';
import 'package:musify/widgets/song_selection_bar.dart';
import 'package:musify/widgets/song_track.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void alertDialog({
    required String title,
    required String subTitle,
    required VoidCallback callBack,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceVariant,
        title: errorText(title),
        content: whiteTextSmall(subTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: whiteTextSmall('Cancel'),
          ),
          TextButton(onPressed: callBack, child: errorText(title)),
        ],
      ),
    );
  }

  void exitScreen() {
    Navigator.pop(context);
    SystemNavigator.pop();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        } else {
          alertDialog(
            title: 'Exit app',
            subTitle: 'Are you sure to want to exit',
            callBack: () {
              exitScreen();
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(onTap: () {}, child: Image.asset(logo)),
            ),
            title: Row(
              children: [
                Image.asset(musifyTextLogo, height: 28),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    alertDialog(
                      title: 'Logout',
                      subTitle: 'Are you sure to want to logout',
                      callBack: () => logout(context),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceLight,
                  ),
                  icon: Icon(
                    Icons.logout_rounded,
                    color: AppColors.surfaceWhite,
                    size: 20,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.surfaceWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.surfaceDark,
          ),
          backgroundColor: AppColors.surface,
          body: Column(
            children: [
              // Tabs
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final tabNotifier = ref.watch(tabProvider.notifier);
                    return PageView.builder(
                      itemCount: tabs.length,
                      controller: _pageController,
                      onPageChanged: (value) {
                        tabNotifier.changeTab(value);
                        if (value == 1) {
                          ref.watch(searchedTextProvider.notifier).clearState();
                        }
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => tabs[index],
                    );
                  },
                ),
              ),
              SongSelectionBar(),
              SongTrack(),
              PageNavigationBar(pageController: _pageController),
            ],
          ),
        ),
      ),
    );
  }
}
