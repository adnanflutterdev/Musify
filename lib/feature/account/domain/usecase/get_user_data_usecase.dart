import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class GetUserDataUsecase extends FUsecase<UserData?, NoParams> {
  final UserRepository repository;
  GetUserDataUsecase(this.repository);

  @override
  FResult<UserData?> call(NoParams param) async {
    return await repository.getUserData();
  }
}
