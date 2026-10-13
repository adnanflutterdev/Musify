import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:musify/core/const/app_shadow.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/extension/string_extention.dart';
import 'package:musify/core/result/result.dart';
import 'package:musify/core/utils/app_validators.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/core/widgets/buttons/primary_button.dart';
import 'package:musify/core/widgets/custom_text_form_field.dart';
import 'package:musify/core/widgets/snack_bars.dart';
import 'package:musify/core/widgets/user_avatar.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/data/models/username.dart';
import 'package:musify/feature/account/presentation/provider/app_config_provider.dart';
import 'package:musify/feature/account/presentation/provider/edit_profile_provider.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.user});
  final UserData user;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _dobController;

  late DateTime? _dob;
  late String? _selectedGender;
  late ValueNotifier<AvatarData?> _selectedAvatar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool canUseUserName = true;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user.name);
    _userNameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _bioController = TextEditingController(text: widget.user.bio);

    _dob = widget.user.dob;
    _dobController = TextEditingController(
      text: _dob != null ? DateFormat('dd-MM-yyyy').format(_dob!) : '',
    );
    _selectedGender = widget.user.gender?.name;
    _selectedAvatar = ValueNotifier(widget.user.userAvatar);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _bioController.dispose();

    _selectedAvatar.dispose();
    super.dispose();
  }

  void showAvatarDialogue() async {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        final avatarRef = ref.watch(getAvatarProvider);
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusMd),
              ),
            ),
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: Column(
              children: [
                AppSpacing.h8,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Choose Your Avatar',
                          style: context.text.headlineLarge?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                AsyncWhen(
                  value: avatarRef,
                  onData: (avatar) {
                    if (avatar == null) {
                      return Container();
                    }
                    return Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _selectedAvatar,
                        builder: (context, selectedAvatar, _) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 30,
                                  crossAxisSpacing: 30,
                                ),
                            itemCount: avatar.avatars.length,
                            itemBuilder: (context, index) {
                              final currentAvatar = avatar.avatars[index];
                              return Material(
                                color: context.colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _selectedAvatar.value = currentAvatar;
                                    Navigator.pop(context);
                                  },
                                  splashColor: context.colors.primary
                                      .withValues(alpha: 0.2),

                                  child: UserAvatar(
                                    avatar: currentAvatar,
                                    showBorder:
                                        selectedAvatar?.id == currentAvatar.id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void changeDob() async {
    DateTime now = DateTime.now();
    DateTime? newDob = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 12, now.month, now.day),
    );

    if (newDob != null) {
      _dob = newDob;
      _dobController.text = DateFormat('dd-MM-yyyy').format(_dob!);
    }
  }

  // void checkUserNameAvaibility(String? value) {}

  void saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final now = DateTime.now();
      final usernameText = _userNameController.text.trim();
      final updateRef = ref.read(updateUserDataProvider.notifier);

      final bool canChangeUsername = widget.user.username != usernameText;

      final userNameAvailable = canChangeUsername
          ? await updateRef.isUsernameAvailable(usernameText)
          : null;

      if (userNameAvailable == null) {
        updateData(updateRef, now);
        return;
      }

      if (userNameAvailable.data ?? false) {
        final bool success = await changeUsername(updateRef, now);
        if (success) {
          updateData(updateRef, now);
        }
      } else if (mounted) {
        showAppSnackbar(context: context, result: userNameAvailable);
      }
    }
  }

  Future<bool> changeUsername(
    UpdateUserDataNotifier updateRef,
    DateTime now,
  ) async {
    final bool canDeleteUsername = widget.user.username.isNotEmpty;

    final deleteResult = canDeleteUsername
        ? await updateRef.deleteUsername(widget.user.username)
        : null;
    if (deleteResult == null) {
      return await setUsername(updateRef, now);
    }

    return await setUsername(updateRef, now);
  }

  Future<bool> setUsername(
    UpdateUserDataNotifier updateRef,
    DateTime now,
  ) async {
    Username newUsername = Username(
      id: _userNameController.text.trim(),
      uid: widget.user.uid,
      email: widget.user.email,
      createdAt: now,
    );
    final setUserNameResult = await updateRef.setUsername(newUsername);

    if (mounted && !setUserNameResult.success) {
      showAppSnackbar(context: context, result: setUserNameResult);
    }

    return setUserNameResult.success;
  }

  void updateData(UpdateUserDataNotifier updateRef, DateTime now) async {
    final updatedData = UserData.update(
      name: _nameController.text.trim(),
      username: _userNameController.text.trim(),
      dob: _dob,
      gender: _selectedGender != null ? GenderX.gender(_selectedGender!) : null,
      bio: _bioController.text.trim().isNotEmpty
          ? _bioController.text.trim()
          : null,

      userAvatar: _selectedAvatar.value,
      updatedAt: now,
    );

    final updateResult = await updateRef.updateUserData(updatedData);
    if (mounted) {
      showAppSnackbar(context: context, result: updateResult);
    }
    if (updateResult.success && mounted) {
      final _ = ref.invalidate(getUserDataProvider);
      ref.read(editProfileProvider.notifier).toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [_buildAvatarSection(), AppSpacing.h16, _userInfoSection()],
      ),
    );
  }

  Widget _buildAvatarSection() {
    final colors = context.colors;
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: _selectedAvatar,
            builder: (context, avatar, _) {
              if (avatar == null) {
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: colors.surface,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 120,
                      color: colors.textSecondary,
                    ),
                  ),
                );
              } else {
                return UserAvatar(avatar: avatar);
              }
            },
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Material(
              color: colors.background,
              borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
              child: InkWell(
                onTap: showAvatarDialogue,
                splashColor: colors.onError,
                borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: const BoxDecoration(shape: .circle),
                  child: const Icon(Icons.cameraswitch_rounded, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInfoSection() {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [AppShadow.shadowLvl1(context)],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),

      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              label: 'Name',
              hintText: 'Type your name',
              prefixIcon: Icons.person,
              controller: _nameController,
              validator: AppValidators.name,
            ),
            AppSpacing.h12,
            AppTextField(
              label: 'Username',
              hintText: 'Type a username',
              prefixIcon: Icons.alternate_email,
              controller: _userNameController,
              validator: AppValidators.username,
            ),
            AppSpacing.h12,
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Gender', style: context.text.bodyLarge),
                      AppSpacing.h4,
                      DropdownButtonFormField(
                        isExpanded: true,
                        initialValue: _selectedGender,
                        hint: const Text('Select Gender'),
                        items: Gender.values
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender.name,
                                child: Text(gender.name.capitalize),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          _selectedGender = value;
                        },
                      ),
                    ],
                  ),
                ),
                AppSpacing.w8,
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Account Type', style: context.text.bodyLarge),
                      AppSpacing.h4,
                      InkWell(
                        onTap: () {
                          showAppSnackbar(
                            context: context,
                            result: Result.failure(
                              'You can\'t update account type',
                            ),
                          );
                        },
                        child: IgnorePointer(
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            initialValue: widget.user.accountType,
                            hint: const Text('Select accountType'),

                            items: AccountType.values
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender.name.capitalize),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSpacing.h12,

            AppTextField(
              label: 'Date of Birth',
              hintText: 'Select DOB',
              prefixIcon: Icons.calendar_month,
              controller: _dobController,
              minLines: 1,
              maxLines: 4,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              isReadOnly: true,
              onTap: changeDob,
            ),

            AppSpacing.h12,

            InkWell(
              onTap: () {
                showAppSnackbar(
                  context: context,
                  result: Result.failure('You can\'t email from here'),
                );
              },
              child: IgnorePointer(
                child: AppTextField(
                  label: 'Email',
                  isReadOnly: true,
                  prefixIcon: Icons.email,
                  controller: _emailController,
                ),
              ),
            ),
            AppSpacing.h12,
            AppTextField(
              label: 'Bio',
              hintText: 'Add your bio',
              controller: _bioController,
              minLines: 1,
              maxLines: 4,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
            ),

            AppSpacing.h24,

            Builder(
              builder: (context) {
                final updateRef = ref.watch(updateUserDataProvider);
                return PrimaryButton(
                  label: 'Save Changes',
                  onPressed: saveChanges,
                  isLoading: updateRef.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
