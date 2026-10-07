import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncWhen<T> extends StatelessWidget {
  const AsyncWhen({super.key, required this.value, required this.onData});
  final AsyncValue<T> value;

  final Widget Function(T data) onData;
  @override
  Widget build(BuildContext context) {
    return value.when(
      data: onData,
      error: (error, stackTrace) {
        if (kDebugMode) {
          print(error);
          print(stackTrace);
        }
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
