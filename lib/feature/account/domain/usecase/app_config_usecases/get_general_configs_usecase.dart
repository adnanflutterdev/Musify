import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/configs/app_configs.dart';
import 'package:musify/feature/account/domain/repository/app_config_repository.dart';

class GetGeneralConfigsUsecase extends FUsecase<GeneralConfigs?, NoParams> {
  final AppConfigRepository repository;
  GetGeneralConfigsUsecase(this.repository);

  @override
  FResult<GeneralConfigs?> call(NoParams param) async {
    return await repository.getGeneralConfigs();
  }
}
