import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/configs/app_configs.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/presentation/provider/di.dart';

final getGeneralConfigProvider = FutureProvider<GeneralConfigs?>((ref) async {
  final getGeneralConfigsUsecase = ref.read(getGeneralConfigUsecaseProvider);

  Result<GeneralConfigs?> generalConfig = await getGeneralConfigsUsecase(
    NoParams(),
  );

  if (generalConfig.success) {
    return Future<GeneralConfigs>.value(generalConfig.data);
  } else {
    return Future.error(generalConfig.message ?? 'Failed to load configs');
  }
});

final getAvatarProvider = FutureProvider<Avatar?>((ref) async {
  final getGeneralConfigsUsecase = ref.read(getAvatarUsecaseProvider);

  Result<Avatar?> avatar = await getGeneralConfigsUsecase(NoParams());

  if (avatar.success) {
    return Future<Avatar>.value(avatar.data);
  } else {
    return Future.error(avatar.message ?? 'Failed to load configs');
  }
});
