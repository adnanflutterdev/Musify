import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class IsUsernameAvailableUsecase extends FUsecase<bool, IdParam> {
  final UserRepository repository;
  IsUsernameAvailableUsecase(this.repository);

  @override
  FResult<bool> call(IdParam param) async {
    return await repository.isUserNameAvailable(param.id);
  }
}
