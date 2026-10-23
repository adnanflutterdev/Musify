import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/song/data/models/new_song.dart';
import 'package:musify/feature/song/domain/repository/songs_repository.dart';

class LoadSongsUsecase extends FUsecase<List<Song>, SongLimitParam> {
  final SongsRepository repository;

  LoadSongsUsecase(this.repository);
  @override
  FResult<List<Song>> call(SongLimitParam param) async {
    return await repository.loadSongs(param.limit ?? 30);
  }
}

class SongLimitParam {
  final int? limit;

  SongLimitParam([this.limit]);
}
