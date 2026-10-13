import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/username.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class SetUsenameUsecase extends FUsecase<void, Username> {
  final UserRepository repository;
  SetUsenameUsecase(this.repository);

  @override
  FResult<void> call(Username param) async {
    return await repository.setUsername(param);
  }
}
