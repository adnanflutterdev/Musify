import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musify/core/model/appearance_theme.dart';
import 'package:musify/core/services/providers/theme_provider.dart';
import 'package:musify/core/theme/app_colors.dart';
import 'package:musify/core/theme/app_theme.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/core/utils/app_preferences.dart';
import 'package:musify/firebase_options.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musify/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/audio/audio_player_handler.dart';

late final AudioPlayerHandler audioHandler;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppPreferences.initialize();

  // AudioService setup
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.musify.app.audio',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/launcher_ic',
    ),
  );

  runApp(const ProviderScope(child: Musify()));
}

class Musify extends ConsumerWidget {
  const Musify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenSize.init(context);
    final appearance = ref.watch(appearanceProvider);

    final themeMode = appearance.themeMode;
    final platformBrightness = MediaQuery.platformBrightnessOf(context);

    final isDarkMode = switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => platformBrightness == Brightness.dark,
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar background
        statusBarColor: isDarkMode
            ? AppThemeColors.darkSurface
            : AppThemeColors.lightSurface,

        // Android status bar icons and text
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,

        // iOS status bar appearance
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,

        // Bottom navigation bar
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: MaterialApp(
        title: 'Musify',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: const SplashScreen(),
        navigatorKey: AppNavigator.navigatorKey,
        debugShowCheckedModeBanner: false,

        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              
              textScaler: TextSizeX.getScaler(appearance.textSize),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
