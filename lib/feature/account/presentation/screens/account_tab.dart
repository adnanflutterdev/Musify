import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/user_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/widgets/buttons/primary_button.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/presentation/screens/account_settings/appearances_settings.dart';
import 'package:musify/feature/account/presentation/screens/profile_screen.dart';
import 'package:musify/feature/auth/presentation/provider/auth_provider.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';
import 'package:musify/feature/account/presentation/provider/app_config_provider.dart';

class AccountTab extends ConsumerStatefulWidget {
  const AccountTab({super.key});

  @override
  ConsumerState<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends ConsumerState<AccountTab> {
  @override
  Widget build(BuildContext context) {
    final userRef = ref.watch(userDataProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          AsyncWhen(
            value: userRef,
            onData: (user) {
              if (user == null) {
                return Container();
              } else {
                return Column(
                  children: [
                    _buildProfileSection(user),
                    AppSpacing.h16,
                    _buildAccountSection(
                      title: 'Your Musify',
                      children: [
                        _buildSectionCard(
                          title: 'Musify Premium',
                          subTitle: 'Manage your membership',
                          icon: Icons.workspace_premium,
                          onTap: () {},
                        ),
                      ],
                    ),
                    _buildAccountSection(
                      title: 'Preferences',
                      children: [
                        _buildSectionCard(
                          title: 'Playback & Audio',
                          subTitle: 'Quality, equalizer, autoplay',
                          icon: Icons.workspace_premium,
                          onTap: () {},
                        ),
                        _buildSectionCard(
                          title: 'Appearance',
                          subTitle: 'Theme and personalization',
                          icon: Icons.color_lens_outlined,
                          onTap: () {
                            AppNavigator.pushDelayed(
                              const AppearancesSettings(),
                            );
                          },
                        ),
                        _buildSectionCard(
                          title: 'Download & Storage',
                          subTitle: 'Offline music and cache',
                          icon: Icons.download_rounded,
                          onTap: () {},
                        ),
                        _buildSectionCard(
                          title: 'Notifications',
                          subTitle: 'Manage your alerts',
                          icon: Icons.notifications_outlined,
                          onTap: () {},
                        ),
                      ],
                    ),
                    _buildAccountSection(
                      haveDivider: false,
                      title: 'Account & Support',
                      children: [
                        _buildSectionCard(
                          title: 'Privacy & Security',
                          icon: Icons.verified_user_outlined,
                          onTap: () {},
                        ),
                        _buildSectionCard(
                          title: 'Help & Support',
                          icon: Icons.help_outline,
                          onTap: () {},
                        ),
                        _buildSectionCard(
                          title: 'About Musify',
                          icon: Icons.error_outline,
                          onTap: () {},
                        ),

                        AppSpacing.h12,
                        _buildLogoutButton(),
                        AppSpacing.h12,
                        _buildAppDetails(),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(UserData user) {
    return Material(
      color: context.colors.transparent,
      child: InkWell(
        onTap: () => AppNavigator.pushDelayed(const ProfileScreen()),
        splashColor: context.colors.selection,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              if (user.userAvatar == null)
                _buildDefaultAvatar()
              else
                UserAvatar(
                  avatar: user.userAvatar!,
                  showBorder: false,
                  size: 80,
                ),

              AppSpacing.w12,

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(user.name, style: context.text.titleMedium),
                    if (user.username.trim().isNotEmpty)
                      RichText(
                        text: TextSpan(
                          text: '@',
                          style: context.text.bodyMedium?.copyWith(
                            color: context.colors.primary,
                          ),
                          children: [
                            TextSpan(
                              text: user.username,
                              style: context.text.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    Text(
                      'View and edit your profile',
                      style: context.text.bodyMedium?.copyWith(
                        color: context.colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: context.colors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    final avatarRef = ref.watch(avatarProvider);
    return AsyncWhen(
      value: avatarRef,
      onData: (avatar) {
        if (avatar == null) {
          return const SizedBox.shrink();
        }
        return UserAvatar(avatar: avatar.defaultAvatar, size: 80);
      },
    );
  }

  Widget _buildAccountSection({
    required String title,
    required List<Widget> children,
    bool haveDivider = true,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: context.text.headlineMedium),
        AppSpacing.h8,
        ...children,
        AppSpacing.h16,
        if (haveDivider) ...[const Divider(), AppSpacing.h24],
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    String? subTitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: context.colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: context.colors.selection,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  color: context.colors.surface,
                ),
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(icon, color: context.colors.primaryLight),
              ),

              AppSpacing.w12,

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: context.text.titleMedium?.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: .w500,
                      ),
                    ),
                    if (subTitle != null)
                      Text(
                        subTitle,
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.textTertiary,
                        ),
                      ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: context.colors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    final authRef = ref.watch(authProvider);

    return PrimaryButton(
      onPressed: () {
        ref.read(authProvider.notifier).logout();
      },

      isBordered: true,
      icon: Icons.logout_outlined,
      iconSize: 25,
      isLoading: authRef.isLoading,
      foregroundColor: context.colors.error,
      backgroundColor: context.colors.error.withValues(alpha: 0.1),
      label: 'Logout',
    );
  }

  Widget _buildAppDetails() {
    final generalConfigs = ref.watch(generalConfigProvider);

    return AsyncWhen(
      value: generalConfigs,
      onData: (configs) {
        if (configs == null) {
          return const SizedBox.shrink();
        } else {
          return Center(
            child: Text(
              '${configs.app.name} ● Version ${configs.app.latestVersion}',
            ),
          );
        }
      },
    );
  }
}
