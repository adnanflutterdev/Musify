import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/listening/domain/repository/listening_repository.dart';

class AddRecentlyPlayedUsecase extends FUsecase<void, AddRecentlyPlayedParams> {
  final ListeningRepository repository;
  AddRecentlyPlayedUsecase(this.repository);

  @override
  FResult<void> call(AddRecentlyPlayedParams param) async {
    return await repository.addRecentlyPlayed(
      recentlyPlayed: param.recentlyPlayed,
      canUpdate: param.canUpdate,
      docToBeDeleted: param.docToBeDeleted,
    );
  }
}

class AddRecentlyPlayedParams {
  final RecentlyPlayed recentlyPlayed;
  final bool canUpdate;
  final String? docToBeDeleted;

  AddRecentlyPlayedParams({
    required this.recentlyPlayed,
    required this.canUpdate,
    this.docToBeDeleted,
  });
}
