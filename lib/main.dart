import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musify/core/theme/app_colors.dart';
import 'package:musify/core/theme/app_theme.dart';
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

  runApp(const RestartWidget(child: Musify()));
}

// RestartWidget for completely reseting all providers.
class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({super.key, required this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(key: key, child: widget.child);
  }
}

class Musify extends StatelessWidget {
  const Musify({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: .light,
        statusBarColor: AppThemeColors.lightSurface,
      ),
      child: MaterialApp(
        title: 'Musify',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
