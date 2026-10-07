import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/configs/app_configs.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';

abstract interface class AppConfigRepository {
  FResult<GeneralConfigs?> getGeneralConfigs();
  FResult<Avatar> getAvatars();
}
