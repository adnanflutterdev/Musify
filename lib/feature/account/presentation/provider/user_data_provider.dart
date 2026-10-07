import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/usecase/usecase.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/presentation/provider/di.dart';

final getUserDataProvider = FutureProvider<UserData?>((ref) async {
  final getUserDataUsecase = ref.read(getUserDataUsecaseProvider);

  Result<UserData?> generalConfig = await getUserDataUsecase(NoParams());

  if (generalConfig.success) {
    return Future<UserData>.value(generalConfig.data);
  } else {
    return Future.error(generalConfig.message ?? 'Failed to load configs');
  }
});
