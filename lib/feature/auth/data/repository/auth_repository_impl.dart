import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/auth/data/data_source/auth_data_source.dart';
import 'package:musify/feature/auth/domain/repository/auth_repository.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  FResult<void> login(LoginParams params) async {
    try {
      await dataSource.login(params);
      return Result.success(data: null, message: 'You logged in successfully');
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Failed to login');
    } catch (e) {
      return Result.failure('Failed to login');
    }
  }

  @override
  FResult<UserCredential> signup(SignupParams params) async {
    try {
      final credential = await dataSource.signup(params);
      final user = credential.user;
      if (user != null) {
        await dataSource.setUserData(params: params, user: user);
        return Result.success(
          data: null,
          message: 'Account created successfully',
        );
      } else {
        return Result.failure('Failed to create your account');
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Failed to login');
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to login');
    } catch (e) {
      return Result.failure('Failed to login');
    }
  }

  @override
  FResult<void> googleSignIn() async {
    try {
      final credential = await dataSource.googleSignIn();
      final user = credential.user;
      if (user != null) {
        final userExists = await dataSource.userExists(user.uid);
        if (!userExists) {
          await dataSource.setUserData(user: user);
        }
        return Result.success(
          data: null,
          message: userExists
              ? 'You logged in successfully'
              : 'Account created successfully',
        );
      } else {
        return Result.failure('Failed to create your account');
      }
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Failed to login');
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to login');
    } catch (e) {
      return Result.failure('Failed to login');
    }
  }

  @override
  FResult<void> logout() async {
    try {
      await dataSource.logout();
      return Result.success(data: null, message: 'Logged out successfully');
    } catch (e) {
      return Result.failure('Failed to logout');
    }
  }

  @override
  FResult<void> sendEmailVerificationLink() async {
    try {
      await dataSource.sendEmailVerificationLink();
      return Result.success(
        data: null,
        message: 'Email verification link is sent to your email',
      );
    } on FirebaseException catch (e) {
      return Result.failure(
        e.message ?? 'Email verification link is sent to your email',
      );
    } catch (e) {
      return Result.failure('Email verification link is sent to your email');
    }
  }
}
