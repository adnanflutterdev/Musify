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
      return Result.success(data: null);
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
      if (credential.user != null) {
        print('setting user data');
        await dataSource.setUserData(params);
        return Result.success(data: null);
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
}
