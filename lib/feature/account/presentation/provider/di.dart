import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/account/data/data_source/app_config_data_source.dart';
import 'package:musify/feature/account/data/data_source/user_data_source.dart';
import 'package:musify/feature/account/data/repository/app_config_repository_impl.dart';
import 'package:musify/feature/account/data/repository/user_repository_impl.dart';
import 'package:musify/feature/account/domain/usecase/get_avatar_usecase.dart';
import 'package:musify/feature/account/domain/usecase/get_general_configs_usecase.dart';
import 'package:musify/feature/account/domain/usecase/get_user_data_usecase.dart';

final appConfigDataSourceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return AppConfigDataSource(firestore);
});

final userDataSourceProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return UserDataSource(auth, firestore);
});

final appConfigRepositoryProvider = Provider((ref) {
  final appConfigDataSource = ref.read(appConfigDataSourceProvider);
  return AppConfigRepositoryImpl(appConfigDataSource);
});

final userRepositoryProvider = Provider((ref) {
  final userDataSource = ref.read(userDataSourceProvider);
  return UserRepositoryImpl(userDataSource);
});

final getGeneralConfigUsecaseProvider = Provider((ref) {
  final appConfigRepository = ref.read(appConfigRepositoryProvider);
  return GetGeneralConfigsUsecase(appConfigRepository);
});

final getAvatarUsecaseProvider = Provider((ref) {
  final appConfigRepository = ref.read(appConfigRepositoryProvider);
  return GetAvatarUsecase(appConfigRepository);
});

final getUserDataUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetUserDataUsecase(userRepository);
});
