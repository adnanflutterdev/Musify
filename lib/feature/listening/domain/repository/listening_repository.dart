import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';

abstract interface class ListeningRepository {
  FResult<void> playCountIncrement(String songId);

  FResult<void> addRecentlyPlayed({
    required RecentlyPlayed recentlyPlayed,
    required bool canUpdate,
    String? docToBeDeleted,
  });

  FResult<void> addRecentlyPlayedHistory(RecentlyPlayedHistory history);
}
