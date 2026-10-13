import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class DeleteUsernameUsecase extends FUsecase<void, IdParam> {
  final UserRepository repository;
  DeleteUsernameUsecase(this.repository);

  @override
  FResult<void> call(IdParam param) async {
    return await repository.deleteUsername(param.id);
  }
}
