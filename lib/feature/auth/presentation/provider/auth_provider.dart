import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:musify/feature/auth/presentation/provider/di.dart';

class AuthNotifier extends AsyncNotifier<void> {
  late final LoginUsecase _loginUsecase;
  late final SignupUsecase _signupUsecase;

  @override
  Future<void> build() async {
    _loginUsecase = ref.read(loginUsecaseProvider);
    _signupUsecase = ref.read(signupUsecaseProvider);
  }

  FResult<void> login(LoginParams params) async {
    state = AsyncLoading();
    final result = await _loginUsecase(params);
    state = AsyncData(null);
    return result;
  }

  FResult<void> signup(SignupParams params) async {
    state = AsyncLoading();
    final result = await _signupUsecase(params);
    state = AsyncData(null);
    return result;
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);
