import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/listening/domain/repository/listening_repository.dart';

class PlayCountIncrementUsecase extends FUsecase<void, IdParam> {
  final ListeningRepository repository;
  PlayCountIncrementUsecase(this.repository);
  
  @override
  FResult<void> call(IdParam param) async {
    return await repository.playCountIncrement(param.id);
  }
}
