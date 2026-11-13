import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/favourite_song.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class GetFavouriteSongsUsecase extends SUsecase<List<FavouriteSong>, NoParams> {
  final UserRepository repository;
  GetFavouriteSongsUsecase(this.repository);
  @override
  Stream<List<FavouriteSong>> call(NoParams param) {
    return repository.getFavouriteSongs();
  }
}
