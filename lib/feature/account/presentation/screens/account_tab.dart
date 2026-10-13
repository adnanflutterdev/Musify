import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/di/di.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/collapsible_text.dart';
import 'package:musify/core/widgets/user_avatar.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/presentation/provider/app_config_provider.dart';
import 'package:musify/feature/account/presentation/provider/edit_profile_provider.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';
import 'package:musify/feature/account/presentation/screens/edit_profile_screen.dart';
import 'package:musify/feature/auth/presentation/screens/email_verification_screen.dart';

class AccountTab extends ConsumerStatefulWidget {
  const AccountTab({super.key});

  @override
  ConsumerState<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends ConsumerState<AccountTab> {
  @override
  Widget build(BuildContext context) {
    final userRef = ref.watch(getUserDataProvider);
    final editingProfile = ref.watch(editProfileProvider);
    return AsyncWhen(
      value: userRef,
      onData: (user) {
        if (user == null) {
          return Container();
        } else {
          if (editingProfile) {
            return EditProfileScreen(user: user);
          }
          return Column(
            children: [
              if (user.userAvatar == null)
                _buildDefaultAvatar()
              else
                UserAvatar(avatar: user.userAvatar!),

              AppSpacing.h16,

              _buildUserData(user),
            ],
          );
        }
      },
    );
  }

  Widget _buildDefaultAvatar() {
    final avatarRef = ref.watch(getAvatarProvider);
    return AsyncWhen(
      value: avatarRef,
      onData: (avatar) {
        if (avatar == null) {
          return const SizedBox.shrink();
        }
        return UserAvatar(avatar: avatar.defaultAvatar);
      },
    );
  }

  Widget _buildUserData(UserData user) {
    final colors = context.colors;
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [AppShadow.shadowLvl1(context)],
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),

      padding: const EdgeInsets.all(AppSpacing.md),

      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDataCol(title: 'Name', content: user.name),
              ),
              if (user.subscription != null)
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.workspace_premium, color: colors.warning),
                ),
            ],
          ),

          if (user.subscription != null) AppSpacing.h8 else AppSpacing.h12,

          Row(
            children: [
              Expanded(
                child: _buildDataCol(
                  title: 'Username',
                  content: user.username,
                  icon: Icon(
                    Icons.alternate_email,
                    size: 18,
                    color: colors.primary,
                  ),
                ),
              ),
              Expanded(
                child: _buildDataCol(
                  title: 'DOB',
                  content: user.dob != null
                      ? DateFormat('dd-MM-yyyy').format(user.dob!)
                      : null,
                ),
              ),
            ],
          ),

          AppSpacing.h12,

          Row(
            spacing: 12,
            children: [
              Expanded(
                child: _buildDataCol(
                  title: 'Gender',
                  content: user.gender?.name,
                ),
              ),
              Expanded(
                child: _buildDataCol(
                  title: 'Account Type',
                  spacing: AppSpacing.w8,
                  content: user.accountType.name.toUpperCase(),
                  icon: user.getAccountIcon(context: context),
                ),
              ),
            ],
          ),

          AppSpacing.h12,

          Row(
            crossAxisAlignment: .end,
            children: [
              Expanded(
                child: _buildDataCol(title: 'Email', content: user.email),
              ),
              if (firebaseAuth.currentUser?.emailVerified ?? false)
                Tooltip(
                  message: 'Your email is verified',
                  child: Icon(Icons.verified, color: colors.success),
                )
              else
                Material(
                  color: colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerificationScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                    splashColor: colors.primary.withValues(alpha: 0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      child: Text(
                        'verify',
                        style: context.text.bodyMedium?.copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          AppSpacing.h12,

          _buildDataCol(
            title: 'Bio',
            customContent: CollapsibleText(
              text: user.bio ?? '"NOT ADDED"',
              style: context.text.bodyMedium?.copyWith(
                fontFamily: 'Poppins Italic',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCol({
    required String title,
    String? content,
    Icon? icon,
    SizedBox? spacing,
    Widget? customContent,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: context.text.bodyLarge?.copyWith(
            color: context.colors.primary,
          ),
        ),
        Row(
          children: [
            ?icon,
            ?spacing,
            Flexible(
              child:
                  customContent ??
                  Text(
                    content ?? '"NOT ADDED"',
                    overflow: .ellipsis,
                    style: context.text.bodyMedium?.copyWith(
                      fontFamily: 'Poppins Italic',
                      color: content == null ? context.colors.onError : null,
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
