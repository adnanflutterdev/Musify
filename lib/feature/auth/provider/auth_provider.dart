import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

class AuthState {
  final XFile? image;
  final String gender;
  final String dob;
  final String name;
  final String email;
  final String pass;
  final bool isLoginScreen;
  final bool isSigning;
  final bool isObscure;

  AuthState({
    this.image,
    this.gender = 'Male',
    this.dob = 'DOB',
    this.name = '',
    this.email = '',
    this.pass = '',
    this.isLoginScreen = true,
    this.isSigning = false,
    this.isObscure = true,
  });

  AuthState copyWith({
    XFile? image,
    String? name,
    String? gender,
    String? dob,
    String? email,
    String? pass,
    bool? isLoginScreen,
    bool? isSigning,
    bool? isObscure,
  }) {
    return AuthState(
      image: image ?? this.image,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      pass: pass ?? this.pass,
      isLoginScreen: isLoginScreen ?? this.isLoginScreen,
      isSigning: isSigning ?? this.isSigning,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}

class AuthProviderNotifer extends StateNotifier<AuthState> {
  AuthProviderNotifer() : super(AuthState());

  void updateImage(XFile image) {
    state = state.copyWith(image: image);
  }

  void updategender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void updatedob(String dob) {
    state = state.copyWith(dob: dob);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePass(String pass) {
    state = state.copyWith(pass: pass);
  }

  void updateIsLoginScreen(bool isLoginScreen) {
    state = state.copyWith(isLoginScreen: isLoginScreen);
  }

  void updateIsSigning(bool isSigning) {
    state = state.copyWith(isSigning: isSigning);
  }

  void updateIsObscure(bool isObscure) {
    state = state.copyWith(isObscure: isObscure);
  }
}

final authProvider = StateNotifierProvider<AuthProviderNotifer, AuthState>(
  (ref) => AuthProviderNotifer(),
);
