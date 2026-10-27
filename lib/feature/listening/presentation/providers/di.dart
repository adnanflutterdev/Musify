import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/feature/listening/data/data_source/listening_data_source.dart';
import 'package:musify/feature/listening/data/repository/listening_repository_impl.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_history_usecase.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_usecase.dart';
import 'package:musify/feature/listening/domain/usecase/play_count_increment_usecase.dart';

final listeningDataSourceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);

  return ListeningDataSource(firestore, auth);
});

final listeningRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(listeningDataSourceProvider);

  return ListeningRepositoryImpl(dataSource);
});

final playCountIncrementUsecaseProvider = Provider((ref) {
  final repository = ref.read(listeningRepositoryProvider);
  return PlayCountIncrementUsecase(repository);
});

final addRecentlyPlayedUsecaseProvider = Provider((ref) {
  final repository = ref.read(listeningRepositoryProvider);
  return AddRecentlyPlayedUsecase(repository);
});

final addRecentlyPlayedHistoryUsecaseProvider = Provider((ref) {
  final repository = ref.read(listeningRepositoryProvider);
  return AddRecentlyPlayedHistoryUsecase(repository);
});
