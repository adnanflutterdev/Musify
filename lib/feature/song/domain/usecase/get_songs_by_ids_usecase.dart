import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:musify/feature/song/domain/repository/songs_repository.dart';

class GetSongsByIdsUsecase
    extends FUsecase<List<Song>, GetSongsByIdsUsecaseParams> {
  final SongsRepository repository;
  GetSongsByIdsUsecase(this.repository);

  @override
  FResult<List<Song>> call(GetSongsByIdsUsecaseParams param) async {
    return await repository.getSongsByIds(param.songsIds);
  }
}

class GetSongsByIdsUsecaseParams(final List<String> songsIds);
