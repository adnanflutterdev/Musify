import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user_data.dart';

abstract interface class UserRepository {
  FResult<UserData?> getUserData();
}
