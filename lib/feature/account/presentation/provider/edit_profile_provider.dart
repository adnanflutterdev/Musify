import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

final editProfileProvider = NotifierProvider.autoDispose(
  () => EditProfileNotifier(),
);
