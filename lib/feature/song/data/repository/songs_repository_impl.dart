import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/song/data/data_source/songs_data_source.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:musify/feature/song/domain/repository/songs_repository.dart';

class SongsRepositoryImpl implements SongsRepository {
  final SongsDataSource dataSource;

  SongsRepositoryImpl(this.dataSource);
  @override
  FResult<List<Song>> loadSongs(int limit) async {
    try {
      final loadedSongs = await dataSource.loadSongs(limit);

      if (loadedSongs.isEmpty) {
        return Result.failure('No more songs to load');
      }

      return Result.success(data: loadedSongs);
    } on FirebaseException catch (e) {
      return Result.failure(e.message ?? 'Failed to load songs');
    } catch (e) {
      return Result.failure('Failed to load songs');
    }
  }

  @override
  FResult<List<Song>> getSongsByIds(List<String> songIds) async {
    try {
      final loadedSongs = await dataSource.getSongsByIds(songIds);

      return Result.success(data: loadedSongs);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return Result.failure(e.message ?? 'Failed to load songs');
    } catch (e) {
      debugPrint(e.toString());
      return Result.failure('Failed to load songs');
    }
  }
}
