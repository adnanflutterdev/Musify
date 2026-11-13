import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/favourite_song.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/data/models/user/username.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/toggle_favourite_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/delete_username_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/is_username_available_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/set_usename_usecase.dart';
import 'package:musify/feature/account/domain/usecase/user_usecases/update_user_data_usecase.dart';
import 'package:musify/feature/account/presentation/provider/di.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';

class UpdateUserDataNotifier extends AsyncNotifier<void> {
  late UpdateUserDataUsecase _updateUserDataUsecase;
  late IsUsernameAvailableUsecase _isUsernameAvailableUsecase;
  late DeleteUsernameUsecase _deleteUsernameUsecase;
  late SetUsenameUsecase _setUsenameUsecase;
  late ToggleFavouriteUsecase _toggleFavouriteUsecase;

  @override
  FutureOr<void> build() {
    _updateUserDataUsecase = ref.read(updateUserDataUsecaseProvider);
    _isUsernameAvailableUsecase = ref.read(isUsernameAvailabeUsecaseProvider);
    _deleteUsernameUsecase = ref.read(deleteUsernameUsecaseProvider);
    _setUsenameUsecase = ref.read(setUsernameUsecaseProvider);
    _toggleFavouriteUsecase = ref.read(toggleFavouriteUsecaseProvider);
  }

  FResult<void> updateUserData(Map<String, dynamic> updatedData) async {
    state = const AsyncLoading();
    final result = await _updateUserDataUsecase(
      UpdateUserDataParams(updatedData),
    );
    state = const AsyncData(null);
    return result;
  }

  FResult<bool> isUsernameAvailable(String username) async {
    state = const AsyncLoading();
    final result = await _isUsernameAvailableUsecase(IdParam(username));
    state = const AsyncData(null);
    return result;
  }

  FResult<void> deleteUsername(String username) async {
    state = const AsyncLoading();
    final result = await _deleteUsernameUsecase(IdParam(username));
    state = const AsyncData(null);
    return result;
  }

  FResult<void> setUsername(Username username) async {
    state = const AsyncLoading();
    final result = await _setUsenameUsecase(username);
    state = const AsyncData(null);
    return result;
  }

  FResult<void> toggleFavouriteSong(String songId, bool isFavourite) async {
    state = const AsyncLoading();
    final result = await _toggleFavouriteUsecase(
      ToggleFavouriteUsecaseParams(songId, isFavourite),
    );
    state = const AsyncData(null);
    return result;
  }
}

final updateUserDataProvider = AsyncNotifierProvider(
  () => UpdateUserDataNotifier(),
);

final userDataProvider = FutureProvider<UserData?>((ref) async {
  final user = await ref.watch(authStateProvider.future);

  if (user == null) return null;

  final getUserDataUsecase = ref.read(getUserDataUsecaseProvider);
  final result = await getUserDataUsecase(NoParams());

  if (result.success) {
    return result.data;
  }

  throw Exception(result.message ?? 'Failed to load user data');
});

final recentlyPlayedProvider = StreamProvider<List<RecentlyPlayed>>((ref) {
  final usecase = ref.read(getRecentlyPlayedUsecaseProvider);
  return usecase(NoParams());
});

final recentlyPlayedHistoryProvider =
    FutureProvider<List<RecentlyPlayedHistory>>((ref) async {
      final usecase = ref.read(getRecentlyPlayedHistoryUsecaseProvider);
      final result = await usecase(NoParams());
      if (result.success) {
        return result.data ?? [];
      }
      return Future.error(
        result.message ?? 'Failed to get recently played history songs',
      );
    });

final favouriteSongsProvider = StreamProvider<List<FavouriteSong>>((ref) {
  final usecase = ref.read(getFavouriteSongsUsecaseProvider);
  return usecase(NoParams());
});
