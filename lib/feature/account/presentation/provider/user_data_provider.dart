import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/data/models/user/username.dart';
import 'package:musify/feature/account/domain/usecase/delete_username_usecase.dart';
import 'package:musify/feature/account/domain/usecase/is_username_available_usecase.dart';
import 'package:musify/feature/account/domain/usecase/set_usename_usecase.dart';
import 'package:musify/feature/account/domain/usecase/update_user_data_usecase.dart';
import 'package:musify/feature/account/presentation/provider/di.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';

class UpdateUserDataNotifier extends AsyncNotifier<void> {
  late UpdateUserDataUsecase _updateUserDataUsecase;
  late IsUsernameAvailableUsecase _isUsernameAvailableUsecase;
  late DeleteUsernameUsecase _deleteUsernameUsecase;
  late SetUsenameUsecase _setUsenameUsecase;

  @override
  FutureOr<void> build() {
    _updateUserDataUsecase = ref.read(updateUserDataUsecaseProvider);
    _isUsernameAvailableUsecase = ref.read(isUsernameAvailabeUsecaseProvider);
    _deleteUsernameUsecase = ref.read(deleteUsernameUsecaseProvider);
    _setUsenameUsecase = ref.read(setUsernameUsecaseProvider);
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
}

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

final updateUserDataProvider = AsyncNotifierProvider(
  () => UpdateUserDataNotifier(),
);

final recentlyPlayedProvider = FutureProvider<List<RecentlyPlayed>>((
  ref,
) async {
  final usecase = ref.read(getRecentlyPlayedUsecaseProvider);
  final result = await usecase(NoParams());
  if (result.success) {
    return result.data ?? [];
  }
  return Future.error(result.message ?? 'Failed to get recently played songs');
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
