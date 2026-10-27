import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/listening/domain/repository/listening_repository.dart';

class AddRecentlyPlayedHistoryUsecase
    extends FUsecase<void, AddRecentlyPlayedHistoryParams> {
  final ListeningRepository repository;
  AddRecentlyPlayedHistoryUsecase(this.repository);

  @override
  FResult<void> call(AddRecentlyPlayedHistoryParams param) async{
    return await repository.addRecentlyPlayedHistory(param.history);
  }
}

class AddRecentlyPlayedHistoryParams(final RecentlyPlayedHistory history);
