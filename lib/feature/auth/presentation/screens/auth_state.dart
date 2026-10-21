import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/feature/app/presentation/screen/home_screen.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';
import 'package:musify/feature/auth/presentation/screens/auth_screen.dart';

class AuthState extends ConsumerWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: AsyncWhen(
        value: authState,
        onData: (user) {
          if (user == null) {
            return const AuthScreen();
          } else {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
