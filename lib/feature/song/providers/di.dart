import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/song/data/data_source/songs_data_source.dart';
import 'package:musify/feature/song/data/repository/songs_repository_impl.dart';
import 'package:musify/feature/song/domain/usecase/get_songs_by_ids_usecase.dart';
import 'package:musify/feature/song/domain/usecase/load_songs_usecase.dart';

final songsDataSourceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return SongsDataSource(firestore);
});

final songsRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(songsDataSourceProvider);
  return SongsRepositoryImpl(dataSource);
});

final loadSongsUsecaseProvider = Provider((ref) {
  final repository = ref.read(songsRepositoryProvider);
  return LoadSongsUsecase(repository);
});

final getSongsByIdsUsecaseProvider = Provider((ref) {
  final repository = ref.read(songsRepositoryProvider);
  return GetSongsByIdsUsecase(repository);
});
