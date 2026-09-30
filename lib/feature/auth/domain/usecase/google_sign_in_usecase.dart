import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/auth/domain/repository/auth_repository.dart';

class GoogleSignInUsecase extends FUsecase<void, NoParams> {
  final AuthRepository repository;

  GoogleSignInUsecase(this.repository);

  @override
  FResult<void> call(NoParams param) async {
    return await repository.googleSignIn();
  }
}
