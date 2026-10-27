import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_history_usecase.dart';
import 'package:musify/feature/listening/domain/usecase/add_recently_played_usecase.dart';
import 'package:musify/feature/listening/domain/usecase/play_count_increment_usecase.dart';
import 'package:musify/feature/listening/presentation/providers/di.dart';

class ListeningNotifier extends Notifier<void> {
  late PlayCountIncrementUsecase _playCountIncrementUsecase;
  late AddRecentlyPlayedUsecase _addRecentlyPlayedUsecase;
  late AddRecentlyPlayedHistoryUsecase _addRecentlyPlayedHistoryUsecase;
  @override
  void build() {
    _playCountIncrementUsecase = ref.read(playCountIncrementUsecaseProvider);
    _addRecentlyPlayedUsecase = ref.read(addRecentlyPlayedUsecaseProvider);
    _addRecentlyPlayedHistoryUsecase = ref.read(
      addRecentlyPlayedHistoryUsecaseProvider,
    );
  }

  Future<Result> playCountIncrement(IdParam params) async {
    return await _playCountIncrementUsecase(params);
  }

  Future<Result> addRecentlyPlayed(AddRecentlyPlayedParams params) async {
    return await _addRecentlyPlayedUsecase(params);
  }

  Future<Result> addRecentlyPlayedHistory(
    AddRecentlyPlayedHistoryParams params,
  ) async {
    return await _addRecentlyPlayedHistoryUsecase(params);
  }
}

final listeningProvider = NotifierProvider<ListeningNotifier, void>(
  () => ListeningNotifier(),
);
