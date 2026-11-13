import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/account/data/data_source/app_config_data_source.dart';
import 'package:musify/feature/account/data/data_source/user_data_source.dart';
import 'package:musify/feature/account/data/repository/app_config_repository_impl.dart';
import 'package:musify/feature/account/data/repository/user_repository_impl.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/toggle_favourite_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/delete_username_usecase.dart';
import 'package:musify/feature/account/domain/usecase/app_config_usecases/get_avatar_usecase.dart';
import 'package:musify/feature/account/domain/usecase/app_config_usecases/get_general_configs_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/get_favourite_songs_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/get_recently_played_history_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/get_recently_played_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/get_user_data_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/is_username_available_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/set_usename_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/update_user_data_usecase.dart';

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

final updateUserDataUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UpdateUserDataUsecase(userRepository);
});

final isUsernameAvailabeUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return IsUsernameAvailableUsecase(userRepository);
});

final deleteUsernameUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return DeleteUsernameUsecase(userRepository);
});

final setUsernameUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return SetUsenameUsecase(userRepository);
});

final getRecentlyPlayedUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetRecentlyPlayedUsecase(userRepository);
});

final getRecentlyPlayedHistoryUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetRecentlyPlayedHistoryUsecase(userRepository);
});

final toggleFavouriteUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return ToggleFavouriteUsecase(userRepository);
});

final getFavouriteSongsUsecaseProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetFavouriteSongsUsecase(userRepository);
});
