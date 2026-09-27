class AppValidators {
  AppValidators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    final regExp = RegExp(r'^[a-zA-Z ]{3,}$');
    if (!regExp.hasMatch(value.trim())) {
      return 'Name is too short';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+.\.[a-zA-Z]{2,}$');
    if (!regExp.hasMatch(value.trim())) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    final regExp = RegExp(
      r'''^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[`~!@#$%^&*()_\-+={}\[\]}|\\;:"',<.>/?]).{8,}$''',
    );
    if (!regExp.hasMatch(value.trim())) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? cnfPassword(String? value, String? password) {
    if (value != password) {
      return 'Password doesn\'t match';
    }
    return null;
  }
}
