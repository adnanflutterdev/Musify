import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/widgets/async_when.dart';
import 'package:musify/feature/account/presentation/provider/user_data_provider.dart';

class AccountTab extends ConsumerStatefulWidget {
  const AccountTab({super.key});

  @override
  ConsumerState<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends ConsumerState<AccountTab> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(getUserDataProvider);
    return AsyncWhen(
      value: user,
      onData: (data) {
        return Container();
      },
    );
  }
}
