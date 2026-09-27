import 'package:musify/core/typedefs/typedefs.dart';

abstract class FUsecase<T, Param> {
  FResult<T> call(Param param);
}

abstract class SUsecase<T, Param> {
  FResult<T> call(Param param);
}

class NoParams();

class IdParam(final String id);

