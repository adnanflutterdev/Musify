import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/data_source/app_config_data_source.dart';
import 'package:musify/feature/account/data/models/configs/app_configs.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/domain/repository/app_config_repository.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  final AppConfigDataSource dataSource;
  AppConfigRepositoryImpl(this.dataSource);

  @override
  FResult<GeneralConfigs?> getGeneralConfigs() async {
    try {
      GeneralConfigs? config = await dataSource.getGeneralConfigs();

      if (config == null) {
        return Result.failure('Failed to load configs');
      }
      return Result.success(data: config);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to load configs');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Result.failure('Failed to load configs');
    }
  }

  @override
  FResult<Avatar> getAvatars() async {
    try {
      Avatar? avatar = await dataSource.getAppAvatars();
      if (avatar == null) {
        return Result.failure('Failed to load avatars');
      }
      return Result.success(data: avatar);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to load avatars');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Result.failure('Failed to load avatars');
    }
  }
}
