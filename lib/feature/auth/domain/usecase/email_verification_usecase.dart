import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/auth/domain/repository/auth_repository.dart';

class EmailVerificationUsecase extends FUsecase<void, NoParams> {
  final AuthRepository repository;

  EmailVerificationUsecase(this.repository);

  @override
  FResult<void> call(NoParams param) async {
    return await repository.sendEmailVerificationLink();
  }
}
