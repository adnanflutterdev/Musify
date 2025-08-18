import 'package:flutter/material.dart';
import 'package:musify/screens/auth_screen.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/screen_size.dart';
import 'package:musify/utils/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.5,
      end: 0.8,
    ).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.surface, toolbarHeight: 1),
      body: SafeArea(
        child: Container(
          width: ScreenSize.width,
          height: ScreenSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.surface,
                AppColors.surface.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset(logo),
                ),
              ),
              Positioned(
                bottom: 10,
                child: SizedBox(
                  width: ScreenSize.width,
                  child: splashScreenText('Musify yourself...'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
