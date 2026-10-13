class AppValidators {
  AppValidators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return 'Name is too short';
    }
    final regExp = RegExp(r'^[a-zA-Z ]{3,}$');
    if (!regExp.hasMatch(value.trim())) {
      return 'Use alphabets only';
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (value.trim().length < 3) {
      return 'Username is too short';
    }
    final regExp = RegExp(r'^[a-zA-Z0-9._]{3,}$');
    if (!regExp.hasMatch(value.trim())) {
      return 'Use alpahbets, period, and underscore only';
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
