import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/data/models/user/username.dart';

abstract interface class UserRepository {
  FResult<UserData?> getUserData();
  FResult<void> updateUserData(Map<String, dynamic> updatedData);
  FResult<bool> isUserNameAvailable(String username);
  FResult<void> deleteUsername(String username);
  FResult<void> setUsername(Username username);
  FResult<List<RecentlyPlayed>> getRecentlyPlayed();
  FResult<List<RecentlyPlayedHistory>> getRecentlyPlayedHistory();
}
