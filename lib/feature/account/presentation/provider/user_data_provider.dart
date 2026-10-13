import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/data/models/username.dart';
import 'package:musify/feature/account/domain/usecase/delete_username_usecase.dart';
import 'package:musify/feature/account/domain/usecase/is_username_available_usecase.dart';
import 'package:musify/feature/account/domain/usecase/set_usename_usecase.dart';
import 'package:musify/feature/account/domain/usecase/update_user_data_usecase.dart';
import 'package:musify/feature/account/presentation/provider/di.dart';

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

final getUserDataProvider = FutureProvider<UserData?>((ref) async {
  final getUserDataUsecase = ref.read(getUserDataUsecaseProvider);

  Result<UserData?> userData = await getUserDataUsecase(NoParams());

  if (userData.success) {
    return Future<UserData>.value(userData.data);
  } else {
    return Future.error(userData.message ?? 'Failed to load your data');
  }
});

final updateUserDataProvider = AsyncNotifierProvider(
  UpdateUserDataNotifier.new,
);
