import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/auth/domain/repository/auth_repository.dart';

class LoginUsecase extends FUsecase<void, LoginParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  FResult<void> call(LoginParams params) async {
    return repository.login(params);
  }
}

class LoginParams(final String email, final String password);
