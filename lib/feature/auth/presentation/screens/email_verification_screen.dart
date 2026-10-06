import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/widgets/buttons/primary_button.dart';
import 'package:musify/core/widgets/custom_app_bar.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/core/widgets/snack_bars.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isverficationSent = false;

  Future<void> sendEmailVerifcation(WidgetRef ref) async {
    final notifier = ref.read(authProvider.notifier);

    final result = await notifier.sendEmailVerification();
    if (mounted) {
      showAppSnackbar(context: context, result: result);
      _isverficationSent = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return CustomScaffold(
      appBar: CustomAppBar(
        buildAppLogo: true,
        title: Text(
          'Verify email',
          style: context.text.displaySmall?.copyWith(
            color: colors.primary,
            letterSpacing: 1.1,
            fontFamily: 'Serif',
          ),
          textScaler: TextScaler.noScaling,
        ),
      ),

      body: Consumer(
        builder: (context, ref, _) {
          final auth = ref.watch(firebaseAuthProvider);
          final email = auth.currentUser?.email ?? '';

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  // Verification illustration
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_rounded,
                      size: 58,
                    ),
                  ),

                  AppSpacing.h24,

                  // Title
                  Text(
                    'Verify your email',
                    textAlign: TextAlign.center,
                    style: context.text.headlineMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  AppSpacing.h12,

                  // Description
                  Text(
                    'Please verify your email address to keep your '
                    'account secure and prevent unauthorized access.',
                    textAlign: TextAlign.center,
                    style: context.text.bodyLarge?.copyWith(
                      color: colors.textSecondary.withValues(alpha: 0.65),
                      height: 1.5,
                    ),
                  ),

                  AppSpacing.h24,

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [AppShadow.shadowLvl1(context)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email address',
                          style: context.text.labelLarge?.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.6),
                          ),
                        ),

                        AppSpacing.h12,

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: colors.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: colors.primary.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colors.primary.withValues(alpha: 0.10),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                  color: colors.primary,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.text.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppSpacing.h20,

                        PrimaryButton(
                          onPressed: _isverficationSent
                              ? null
                              : () => sendEmailVerifcation(ref),
                          label: _isverficationSent
                              ? 'Verify email'
                              : 'Send verification email',
                          style: context.text.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.h20,

                  // Already verified
                  ...[
                    TextButton(
                      onPressed: () {
                        auth.signOut();
                      },
                      child: Text(
                        'I have verified my email!\nLogin again',
                        textAlign: .center,
                        style: context.text.bodyMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppSpacing.h12,
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 17,
                        color: colors.textTertiary.withValues(alpha: 0.5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Didn't receive the email?",
                        style: context.text.bodySmall?.copyWith(
                          color: colors.textTertiary.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend email',
                      style: context.text.bodyMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
