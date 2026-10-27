import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/data_source/user_data_source.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/data/models/user/username.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;
  UserRepositoryImpl(this.dataSource);

  @override
  FResult<UserData?> getUserData() async {
    try {
      UserData? user = await dataSource.getUserData();
      if (user == null) {
        return Result.failure('Failed to fetch your data');
      }
      return Result.success(data: user);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to fetch your data');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to fetch your data');
    }
  }

  @override
  FResult<void> updateUserData(Map<String, dynamic> updatedData) async {
    try {
      await dataSource.updateUserData(updatedData);
      return Result.success(
        data: null,
        message: 'Your data updated successfully!!!',
      );
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to update your data');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to update your data');
    }
  }

  @override
  FResult<bool> isUserNameAvailable(String username) async {
    try {
      final bool isAvailable = await dataSource.isUserNameAvailable(username);
      if (isAvailable) {
        return Result.success(data: isAvailable);
      } else {
        return Result.failure('This username is already occupied');
      }
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to check username avaibility');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to check username avaibility');
    }
  }

  @override
  FResult<void> deleteUsername(String username) async {
    try {
      await dataSource.deleteUsername(username);
      return Result.success(data: null, message: '');
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to delete username');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to delete username');
    }
  }

  @override
  FResult<void> setUsername(Username username) async {
    try {
      await dataSource.setUsername(username);
      return Result.success(data: null, message: 'Your username is updated!!!');
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to set username');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to set username');
    }
  }

  @override
  FResult<List<RecentlyPlayed>> getRecentlyPlayed() async {
    try {
      final recentlyPlayed = await dataSource.getRecentlyPlayed();
      return Result.success(data: recentlyPlayed, message: '');
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to get recently played songs');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to get recently played songs');
    }
  }

  @override
  FResult<List<RecentlyPlayedHistory>> getRecentlyPlayedHistory() async {
    try {
      final recentlyPlayedHistory = await dataSource.getRecentlyPlayedHistory();
      return Result.success(data: recentlyPlayedHistory, message: '');
    } on FirebaseException catch (e) {
      return Result.failure(
        e.message ?? 'Failed to get recently history songs',
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return Result.failure('Failed to get recently history songs');
    }
  }
}
