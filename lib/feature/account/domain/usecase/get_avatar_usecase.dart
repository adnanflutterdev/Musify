import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/domain/repository/app_config_repository.dart';

class GetAvatarUsecase extends FUsecase<Avatar?, NoParams> {
  final AppConfigRepository repository;
  GetAvatarUsecase(this.repository);

  @override
  FResult<Avatar?> call(NoParams param) async {
    return await repository.getAvatars();
  }
}
