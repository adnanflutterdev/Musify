import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/auth/data/data_source/auth_data_source.dart';
import 'package:musify/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:musify/feature/auth/domain/usecase/email_verification_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/google_sign_in_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';

final authDataSourceProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);

  return AuthDataSource(auth: auth, firestore: firestore);
});

final authRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(authDataSourceProvider);

  return AuthRepositoryImpl(dataSource);
});

final loginUsecaseProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  return LoginUsecase(authRepository);
});

final signupUsecaseProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  return SignupUsecase(authRepository);
});

final googleSignInUsecaseProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  return GoogleSignInUsecase(authRepository);
});

final logoutUsecaseProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  return LogoutUsecase(authRepository);
});

final emailVerificationUsecaseProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);

  return EmailVerificationUsecase(authRepository);
});
