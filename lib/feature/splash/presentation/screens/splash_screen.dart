import 'package:flutter/material.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/feature/auth/presentation/screens/auth_state.dart';

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
      duration: const Duration(seconds: 2),
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
          MaterialPageRoute(builder: (context) => const AuthState()),
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
    return CustomScaffold(
      body: SafeArea(
        child: Container(
          width: ScreenSize.width,
          height: ScreenSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.colors.background,
                context.colors.background.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset(AppImages.logo),
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Text('Musify yourself...',textAlign: .center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
