import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/data_source/user_data_source.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
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
}
