import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';

abstract interface class AuthRepository {
  FResult<void> login(LoginParams params);
  FResult<void> signup(SignupParams params);
  FResult<void> googleSignIn();
  FResult<void> logout();
  FResult<void> sendEmailVerificationLink();
}
