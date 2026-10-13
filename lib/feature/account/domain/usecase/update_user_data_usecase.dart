import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class UpdateUserDataUsecase extends FUsecase<void, UpdateUserDataParams> {
  final UserRepository repository;
  UpdateUserDataUsecase(this.repository);

  @override
  FResult<void> call(UpdateUserDataParams param) async {
    return repository.updateUserData(param.updatedData);
  }
}

class UpdateUserDataParams(final Map<String, dynamic> updatedData);
