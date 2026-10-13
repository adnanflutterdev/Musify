import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/data/models/username.dart';

abstract interface class UserRepository {
  FResult<UserData?> getUserData();
  FResult<void> updateUserData(Map<String, dynamic> updatedData);
  FResult<bool> isUserNameAvailable(String username);
  FResult<void> deleteUsername(String username);
  FResult<void> setUsername(Username username);
}
