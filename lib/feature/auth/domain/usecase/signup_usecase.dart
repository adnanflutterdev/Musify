import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/auth/domain/repository/auth_repository.dart';

class SignupUsecase extends FUsecase<void, SignupParams> {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  @override
  FResult<void> call(SignupParams params) async {
    return repository.signup(params);
  }
}

class SignupParams(
  final String name,
  final String email,
  final String password,
);
