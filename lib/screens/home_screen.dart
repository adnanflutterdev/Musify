import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/functions/auth_functions.dart';
import 'package:musify/services/providers/song_search_provider.dart';
import 'package:musify/services/providers/tabs_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/tabs.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/page_navigation_bar.dart';
import 'package:musify/widgets/song_selection_bar.dart';
import 'package:musify/widgets/song_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark,
          toolbarHeight: 1,
        ),
        body: SafeArea(
          child: Column(
            children: [
              
              Consumer(
                builder: (context, ref, child) {
                  int tabIndex = ref.watch(tabProvider);

                  return tabIndex == 0
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.surfaceMuted,
                                width: 0.7,
                              ),
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8.0,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(logo, height: 40),
                                ),
                                w10,
                                Image.asset(musifyTextLogo, height: 28),
                                const Spacer(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    alertDialog(
                                      title: 'Logout',
                                      subTitle:
                                          'Are you sure to want to logout',
                                      callBack: () => logout(context),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.surfaceVariant,
                                  ),
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: AppColors.onError,
                                    size: 20,
                                  ),
                                  label: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.onError,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              ),
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
              //  Container(
              //   height: MediaQuery.of(context).padding.bottom,
              //   color: AppColors.surfaceDark,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
