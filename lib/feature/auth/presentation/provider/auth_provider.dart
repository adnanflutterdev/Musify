import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/auth/domain/usecase/email_verification_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:musify/feature/auth/presentation/provider/di.dart';

class AuthNotifier extends AsyncNotifier<void> {
  late final LoginUsecase _loginUsecase;
  late final SignupUsecase _signupUsecase;
  late final EmailVerificationUsecase _emailVerificationUsecase;
  late final GoogleSignInUsecase _googleSignInUsecase;
  late final LogoutUsecase _logoutUsecase;

  @override
  Future<void> build() async {
    _loginUsecase = ref.read(loginUsecaseProvider);
    _signupUsecase = ref.read(signupUsecaseProvider);
    _emailVerificationUsecase = ref.read(emailVerificationUsecaseProvider);
    _googleSignInUsecase = ref.read(googleSignInUsecaseProvider);
    _logoutUsecase = ref.read(logoutUsecaseProvider);
  }

  FResult<void> login(LoginParams params) async {
    state = const AsyncLoading();
    final result = await _loginUsecase(params);
    state = const AsyncData(null);
    return result;
  }

  FResult<void> signup(SignupParams params) async {
    state = const AsyncLoading();
    final result = await _signupUsecase(params);
    state = const AsyncData(null);
    return result;
  }

  FResult<void> googleSignin() async {
    state = const AsyncLoading();
    final result = await _googleSignInUsecase(NoParams());
    state = const AsyncData(null);
    return result;
  }

  FResult<void> logout() async {
    state = const AsyncLoading();
    final result = await _logoutUsecase(NoParams());
    state = const AsyncData(null);
    return result;
  }

  FResult<void> sendEmailVerification() async {
    state = const AsyncLoading();
    final result = await _emailVerificationUsecase(NoParams());
    state = const AsyncData(null);
    return result;
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);
