import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/domain/repository/user_repository.dart';

class ToggleFavouriteUsecase
    extends FUsecase<void, ToggleFavouriteUsecaseParams> {
  final UserRepository repository;
  ToggleFavouriteUsecase(this.repository);
  @override
  FResult<void> call(ToggleFavouriteUsecaseParams param) async {
    return await repository.toggleFavourite(param.songId, param.isFavourite);
  }
}

class ToggleFavouriteUsecaseParams(final String songId, final bool isFavourite);
