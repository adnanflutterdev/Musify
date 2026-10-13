import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/feature/account/data/models/configs/app_configs.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';

class AppConfigDataSource {
  final FirebaseFirestore firestore;

  AppConfigDataSource(this.firestore);

  Future<GeneralConfigs?> getGeneralConfigs() async {
    final appConfig = await firestore
        .collection('appConfigs')
        .doc('general')
        .get();

    if (!appConfig.exists || appConfig.data() == null) return null;
    return GeneralConfigs.fromJson(appConfig.data()!);
  }

  Future<Avatar?> getAppAvatars() async {
    final avatars = await firestore
        .collection('appConfigs')
        .doc('avatar')
        .get();

    if (!avatars.exists || avatars.data() == null) {
      AvatarData defaultAvatar = AvatarData(
        id: 'id',
        name: 'default',
        url: AppImages.coverImageOnline,
        isActive: true,
      );
      return Avatar(enabled: false,defaultAvatar: defaultAvatar, avatars: []);
    }
    return Avatar.fromFirebase(avatars.data()!);
  }
}
