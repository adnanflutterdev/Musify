import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class GetRecentlyPlayedHistoryUsecase
    extends FUsecase<List<RecentlyPlayedHistory>, NoParams> {
  final UserRepository repository;
  GetRecentlyPlayedHistoryUsecase(this.repository);
  @override
  FResult<List<RecentlyPlayedHistory>> call(NoParams param) async {
    return await repository.getRecentlyPlayedHistory();
  }
}
