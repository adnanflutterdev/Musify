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
import 'package:musify/widgets/custom_text_form_field.dart';

class LoginSignup extends ConsumerStatefulWidget {
  const LoginSignup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginSignupState();
}

class _LoginSignupState extends ConsumerState<LoginSignup> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authStateNotifier = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(backgroundColor: AppColors.surface, toolbarHeight: 1),
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
                key: formKey,
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
                            authState.isLoginScreen
                                ? 'Log in to your account'
                                : 'Create a new account',
                          ),
                          h20,

                          // Image here
                          if (!authState.isLoginScreen)
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
                                                authStateNotifier.updateImage(
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
                                                authStateNotifier.updateImage(
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
                                child: authState.image == null
                                    ? Icon(
                                        Icons.camera_alt,
                                        color: AppColors.surfaceWhite,
                                      )
                                    : Image.file(
                                        File(authState.image!.path),
                                        fit: BoxFit.fitWidth,
                                      ),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!authState.isLoginScreen) h20,
                          if (!authState.isLoginScreen)
                            whiteTextSmall('Enter Name'),
                          if (!authState.isLoginScreen) h5,
                          if (!authState.isLoginScreen)
                            CustomTextFormField(
                              hintText: 'Your name',
                              keyboardType: TextInputType.name,
                              errorBorder: true,
                              filledColor: AppColors.surfaceLight,
                              focusedErorBorder: true,
                              onChanged: (newValue) {
                                authStateNotifier.updateName(newValue.trim());
                              },
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
                          if (!authState.isLoginScreen)
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
                                            child: whiteTextSmall(
                                              authState.gender,
                                            ),
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
                                                    authStateNotifier
                                                        .updategender('Male');
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: Text('Female'),
                                                  onTap: () {
                                                    authStateNotifier
                                                        .updategender('Female');
                                                  },
                                                ),
                                                PopupMenuItem(
                                                  child: Text('Others'),
                                                  onTap: () {
                                                    authStateNotifier
                                                        .updategender('Others');
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
                                            child: errorText(authState.dob),
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
                                                authStateNotifier.updatedob(
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
                          if (!authState.isLoginScreen) h20,
                          whiteTextSmall('Enter Email'),
                          h5,
                          CustomTextFormField(
                            hintText: 'your@example.com',
                            keyboardType: TextInputType.emailAddress,
                            errorBorder: true,
                            filledColor: AppColors.surfaceLight,
                            focusedErorBorder: true,
                            onChanged: (newValue) {
                              authStateNotifier.updateEmail(newValue.trim());
                            },
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
                          CustomTextFormField(
                            hintText: '******',
                            isObscure: authState.isObscure,
                            filledColor: AppColors.surfaceLight,
                            keyboardType: TextInputType.visiblePassword,
                            errorBorder: true,
                            focusedErorBorder: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                authStateNotifier.updateIsObscure(
                                  !authState.isObscure,
                                );
                              },
                              icon: Icon(
                                authState.isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primary,
                              ),
                            ),
                            onChanged: (newValue) {
                              authStateNotifier.updatePass(newValue.trim());
                            },
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
                              authStateNotifier.updateIsSigning(true);
                              formKey.currentState!.save();
                              if (authState.isLoginScreen) {
                                await login(
                                  formKey: formKey,
                                  context: context,
                                  auth: authState,
                                );
                              } else {
                                await signup(
                                  formKey: formKey,
                                  auth: authState,
                                  context: context,
                                );
                              }

                              authStateNotifier.updateIsSigning(false);
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryVariant,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: authState.isSigning
                                    ? SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircularProgressIndicator(
                                            color: AppColors.surfaceWhite,
                                          ),
                                        ),
                                      )
                                    : whiteTextSmall(
                                        authState.isLoginScreen
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
                            ' ${authState.isLoginScreen ? 'Don\'t' : 'Already'} have account?',
                          ),
                          TextButton(
                            onPressed: () {
                              authStateNotifier.updateIsLoginScreen(
                                !authState.isLoginScreen,
                              );
                              formKey.currentState!.reset();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            child: primaryTextNormal(
                              authState.isLoginScreen ? 'Sign Up' : 'Log in',
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
