import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musify/functions/auth_functions.dart';
import 'package:musify/services/providers/auth_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/screen_size.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/utils/text_field_borders.dart';

class LoginSignup extends ConsumerStatefulWidget {
  const LoginSignup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginSignupState();
}

class _LoginSignupState extends ConsumerState<LoginSignup> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _pass;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final stateNotifier = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
          backgroundColor: AppColors.surface,
          toolbarHeight: 1,
        ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: ScreenSize.width - 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    color: Colors.black54,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Image.asset(logo, height: 80),
                          musifyText(),
                          whiteTextSmall(
                            state.isLoginScreen
                                ? 'Log in to your account'
                                : 'Create a new account',
                          ),
                          h20,

                          // Image here
                          if (!state.isLoginScreen)
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      height: 60,
                                      color: AppColors.surface,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final result = await ImagePicker()
                                                  .pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                              if (result != null) {
                                                stateNotifier.updateImage(
                                                  result,
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: AppColors.surfaceWhite,
                                              size: 30,
                                            ),
                                          ),
                                          w10,
                                          w10,
                                          IconButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final result = await ImagePicker()
                                                  .pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                              if (result != null) {
                                                stateNotifier.updateImage(
                                                  result,
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.image,
                                              color: AppColors.surfaceWhite,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  shape: BoxShape.circle,
                                ),
                                child: state.image == null
                                    ? Icon(
                                        Icons.camera_alt,
                                        color: AppColors.surfaceWhite,
                                      )
                                    : Image.file(
                                        File(state.image!.path),
                                        fit: BoxFit.fitWidth,
                                      ),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!state.isLoginScreen) h20,
                          if (!state.isLoginScreen)
                            whiteTextSmall('Enter Name'),
                          if (!state.isLoginScreen) h5,
                          if (!state.isLoginScreen)
                            TextFormField(
                              controller: _name,
                              keyboardType: TextInputType.name,
                              cursorColor: AppColors.surfaceWhite,
                              style: TextStyle(color: AppColors.surfaceWhite),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.surfaceLight,
                                hintText: 'Your name',

                                hintStyle: TextStyle(
                                  color: AppColors.onSurfaceLow,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                // Enabled Border
                                enabledBorder: outlinedBorder(
                                  color: AppColors.surfaceWhite,
                                  width: 0.5,
                                ),
                                // Focused Border
                                focusedBorder: outlinedBorder(
                                  color: AppColors.primary,
                                  width: 2.0,
                                ),
                                // Error Border
                                errorBorder: outlinedBorder(
                                  color: AppColors.error,
                                  width: 0.5,
                                ),
                                // Focused Error Border
                                focusedErrorBorder: outlinedBorder(
                                  color: AppColors.primary,
                                  width: 2.0,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'name is required';
                                } else if (value.trim().length < 4) {
                                  return 'name length must be greater than 3';
                                }
                                return null;
                              },
                            ),
                          h20,
                          if (!state.isLoginScreen)
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    whiteTextSmall('Select Gender'),
                                    h5,
                                    Container(
                                      width: ScreenSize.width / 3,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceLight,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.surfaceWhite,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: whiteTextSmall(state.gender),
                                          ),
                                          PopupMenuButton(
                                            iconColor: AppColors.surfaceWhite,
                                            icon: Icon(Icons.arrow_drop_down),
                                            menuPadding: EdgeInsets.all(0),
                                            padding: EdgeInsetsGeometry.all(0),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  child: Text('Male'),
                                                  onTap: () {
                                                    stateNotifier.updategender(
                                                      'Male',
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: Text('Female'),
                                                  onTap: () {
                                                    stateNotifier.updategender(
                                                      'Female',
                                                    );
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: Text('Others'),
                                                  onTap: () {
                                                    stateNotifier.updategender(
                                                      'Others',
                                                    );
                                                  },
                                                ),
                                              ];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    whiteTextSmall('Date of Birth'),
                                    h5,
                                    Container(
                                      width: ScreenSize.width / 2.2,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceLight,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.surfaceWhite,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: errorText(state.dob),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final result =
                                                  await showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime(2015),
                                                  );
                                              if (result != null) {
                                                stateNotifier.updatedob(
                                                  '${result.day}/${result.month}/${result.year}',
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: AppColors.surfaceWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          if (!state.isLoginScreen) h20,
                          whiteTextSmall('Enter Email'),
                          h5,
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.surfaceWhite,
                            style: TextStyle(color: AppColors.surfaceWhite),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.surfaceLight,
                              hintText: 'your@example.com',
                              hintStyle: TextStyle(
                                color: AppColors.onSurfaceLow,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              // Enabled Border
                              enabledBorder: outlinedBorder(
                                color: AppColors.surfaceWhite,
                                width: 0.5,
                              ),
                              // Focused Border
                              focusedBorder: outlinedBorder(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                              // Error Border
                              errorBorder: outlinedBorder(
                                color: AppColors.error,
                                width: 0.5,
                              ),
                              // Focused Error Border
                              focusedErrorBorder: outlinedBorder(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              } else {
                                final emailRegExp = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegExp.hasMatch(value.trim())) {
                                  return 'Enter valid email';
                                }
                                return null;
                              }
                            },
                          ),
                          h20,
                          whiteTextSmall('Enter Password'),
                          h5,
                          TextFormField(
                            controller: _pass,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppColors.surfaceWhite,
                            style: TextStyle(color: AppColors.surfaceWhite),
                            obscureText: state.isObscure,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              filled: true,
                              hintText: '******',
                              fillColor: AppColors.surfaceLight,
                              hintStyle: TextStyle(
                                color: AppColors.onSurfaceLow,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  stateNotifier.updateIsObscure(
                                    !state.isObscure,
                                  );
                                },
                                icon: Icon(
                                  state.isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.primary,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              // Enabled Border
                              enabledBorder: outlinedBorder(
                                color: AppColors.surfaceWhite,
                                width: 0.5,
                              ),
                              // Focused Border
                              focusedBorder: outlinedBorder(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                              // Error Border
                              errorBorder: outlinedBorder(
                                color: AppColors.error,
                                width: 0.5,
                              ),
                              // Focused Error Border
                              focusedErrorBorder: outlinedBorder(
                                color: AppColors.primary,
                                width: 2.0,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              } else {
                                if (value.trim().length < 6) {
                                  return 'Password length must be greater than 6';
                                }
                                return null;
                              }
                            },
                          ),
                          h20,
                          GestureDetector(
                            onTap: () async {
                              stateNotifier.updateIsSigning(true);
                              if (state.isLoginScreen) {
                                await login(
                                  formKey: _formKey,
                                  email: _email,
                                  pass: _pass,
                                  context: context,
                                );
                              } else {
                                await signup(
                                  formKey: _formKey,
                                  name: _name,
                                  email: _email,
                                  pass: _pass,
                                  ref: state,
                                  context: context,
                                );
                              }

                              stateNotifier.updateIsSigning(false);
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryVariant,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: state.isSigning
                                    ? SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          color: AppColors.surfaceWhite,
                                        ),
                                      )
                                    : whiteTextSmall(
                                        state.isLoginScreen
                                            ? 'Log In'
                                            : 'Sign Up',
                                      ),
                              ),
                            ),
                          ),
                          h10,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          darkText(
                            ' ${state.isLoginScreen ? 'Don\'t' : 'Already'} have account?',
                          ),
                          TextButton(
                            onPressed: () {
                              stateNotifier.updateIsLoginScreen(
                                !state.isLoginScreen,
                              );
                              _formKey.currentState!.reset();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            child: primaryTextNormal(
                              state.isLoginScreen ? 'Sign Up' : 'Log in',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
