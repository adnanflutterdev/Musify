import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/listening/data/data_source/listening_data_source.dart';
import 'package:musify/feature/listening/domain/repository/listening_repository.dart';

class ListeningRepositoryImpl implements ListeningRepository {
  final ListeningDataSource dataSource;
  ListeningRepositoryImpl(this.dataSource);

  @override
  FResult<void> playCountIncrement(String songId) async {
    try {
      await dataSource.playCountIncrement(songId);
      return Result.success(data: null);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to update data');
    } catch (e) {
      return Result.failure('Failed to update data');
    }
  }

  @override
  FResult<void> addRecentlyPlayed({
    required RecentlyPlayed recentlyPlayed,
    required bool canUpdate,
    String? docToBeDeleted,
  }) async {
    try {
      await dataSource.addRecentlyPlayed(
        recentlyPlayed: recentlyPlayed,
        canUpdate: canUpdate,
        docToBeDeleted: docToBeDeleted,
      );
      return Result.success(data: null);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to update data');
    } catch (e) {
      return Result.failure('Failed to update data');
    }
  }

  @override
  FResult<void> addRecentlyPlayedHistory(RecentlyPlayedHistory history) async {
    try {
      await dataSource.addRecentlyPlayedHistory(history);
      return Result.success(data: null);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to update data');
    } catch (e) {
      return Result.failure('Failed to update data');
    }
  }
}
