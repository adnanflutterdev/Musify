import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class GetRecentlyPlayedUsecase
    extends FUsecase<List<RecentlyPlayed>, NoParams> {
  final UserRepository repository;
  GetRecentlyPlayedUsecase(this.repository);
  @override
  FResult<List<RecentlyPlayed>> call(NoParams param) async {
    return await repository.getRecentlyPlayed();
  }
}
