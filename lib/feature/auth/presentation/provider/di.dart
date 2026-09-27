import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/auth/data/data_source/auth_data_source.dart';
import 'package:musify/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
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
