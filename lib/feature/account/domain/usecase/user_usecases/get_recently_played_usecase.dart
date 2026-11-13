import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class GetRecentlyPlayedUsecase
    extends SUsecase<List<RecentlyPlayed>, NoParams> {
  final UserRepository repository;
  GetRecentlyPlayedUsecase(this.repository);
  @override
  Stream<List<RecentlyPlayed>> call(NoParams param) {
    return repository.getRecentlyPlayed();
  }
}
