import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/extension/string_extention.dart';
import 'package:musify/core/utils/app_validators.dart';
import 'package:musify/core/widgets/buttons/primary_button.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/core/widgets/custom_text_form_field.dart';
import 'package:musify/core/widgets/snack_bars.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<AuthScreen> {
  bool _isLoginScreen = true;
  bool _isPassObscure = true;
  bool _isCnfPassObscure = true;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passController;
  late TextEditingController _cnfPassController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _cnfPassController = TextEditingController();
  }

  Future<void> _validate(WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final authNotifier = ref.read(authProvider.notifier);

      if (_isLoginScreen) {
        final LoginParams params = LoginParams(
          _emailController.text.trim(),
          _passController.text.trim(),
        );
        final result = await authNotifier.login(params);

        if (!result.success && mounted) {
          showAppSnackbar(context: context, result: result);
        }
      } else {
        final SignupParams params = SignupParams(
          _nameController.text.trim().capitalize,
          _emailController.text.trim(),
          _passController.text.trim(),
        );
        final result = await authNotifier.signup(params);
        if (!result.success && mounted) {
          showAppSnackbar(context: context, result: result);
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _cnfPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildAppBar(),
            AppSpacing.h20,
            _buildForm(),
            AppSpacing.h20,
            _buildToggleButton(),
            AppSpacing.h12,
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final colors = context.colors;
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: colors.surface,
        ),
        Container(
          color: colors.surface,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colors.background,
                  shape: .circle,
                  boxShadow: [AppShadow.shadowLvl1(context)],
                ),
                padding: EdgeInsets.all(8),
                child: Image.asset(AppImages.logo, height: 35),
              ),
              AppSpacing.w8,
              Flexible(
                child: Text(
                  _isLoginScreen ? 'Welcome Back 👋' : 'Create new account',
                  style: context.text.displaySmall?.copyWith(
                    color: colors.primary,
                    letterSpacing: 1.1,
                    fontFamily: 'Serif',
                  ),
                  textScaler: .noScaling,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    final colors = context.colors;

    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // AppSpacing.h20,
                Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [AppShadow.shadowLvl1(context)],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 25.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLoginScreen) ...[
                          AppTextField(
                            label: 'Name',
                            hintText: 'Adnan',
                            controller: _nameController,

                            prefixIcon: Icons.person,

                            validator: AppValidators.name,
                            textInputType: TextInputType.visiblePassword,
                          ),

                          AppSpacing.h20,
                        ],

                        AppTextField(
                          label: 'Email',
                          // label: 'Email or Phone',
                          hintText: 'musify@gmail.com',
                          controller: _emailController,

                          prefixIcon: Icons.person,

                          validator: AppValidators.email,
                          textInputType: TextInputType.emailAddress,
                        ),

                        AppSpacing.h20,

                        AppTextField(
                          label: 'Password',
                          hintText: '••••••••',
                          isObscure: _isPassObscure,
                          controller: _passController,

                          prefixIcon: Icons.lock,
                          suffixIcon: _isPassObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixIconTapped: () {
                            setState(() {
                              _isPassObscure = !_isPassObscure;
                            });
                          },

                          validator: AppValidators.password,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        if (_isLoginScreen) ...[
                          AppSpacing.h4,
                          Align(
                            alignment: .centerStart,
                            child: Text(
                              'Forget password?',
                              style: context.text.labelMedium?.copyWith(
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],

                        if (!_isLoginScreen) ...[
                          AppSpacing.h20,

                          AppTextField(
                            label: 'Confirm Password',
                            hintText: '••••••••',
                            isObscure: _isCnfPassObscure,
                            controller: _cnfPassController,

                            prefixIcon: Icons.lock,
                            suffixIcon: _isCnfPassObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onSuffixIconTapped: () {
                              setState(() {
                                _isCnfPassObscure = !_isCnfPassObscure;
                              });
                            },

                            validator: (value) {
                              return AppValidators.cnfPassword(
                                value,
                                _passController.text,
                              );
                            },
                            textInputType: TextInputType.visiblePassword,
                          ),
                        ],

                        AppSpacing.h32,

                        _buildAuthButton(),
                      ],
                    ),
                  ),
                ),

                AppSpacing.h20,
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(' OR '),
                    Expanded(child: Divider()),
                  ],
                ),
                AppSpacing.h20,

                PrimaryButton(
                  onPressed: () {},
                  elevation: 2,
                  label: 'Continue with Google',
                  backgroundColor: colors.surface,
                  foregroundColor: colors.textPrimary,
                  style: context.text.headlineMedium,
                  leading: Image.asset(AppImages.google, height: 35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton() {
    return Consumer(
      builder: (context, ref, _) {
        final authState = ref.watch(authProvider);

        return PrimaryButton(
          onPressed: () => _validate(ref),
          isLoading: authState.isLoading,
          label: _isLoginScreen ? 'Login' : 'Signup',
        );
      },
    );
  }

  Widget _buildToggleButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _isLoginScreen = !_isLoginScreen;
        });
      },
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: RichText(
          text: TextSpan(
            style: context.text.bodyMedium,
            children: [
              if (_isLoginScreen) ...[
                TextSpan(text: 'New to '),
                TextSpan(
                  text: 'Musify',
                  style: context.text.bodyMedium?.copyWith(
                    color: context.colors.primaryDark,
                  ),
                ),
              ] else
                TextSpan(text: 'Already have an account'),
              TextSpan(text: '? '),
              TextSpan(
                text: _isLoginScreen ? 'Signup' : 'Login',
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
