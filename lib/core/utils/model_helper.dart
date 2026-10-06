import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? parseDate(dynamic value) {
  if (value == null) return null;

  if (value is Timestamp) {
    return value.toDate();
  }

  if (value is DateTime) {
    return value;
  }

  if (value is String) {
    return DateTime.tryParse(value);
  }

  if (value is Map) {
    final seconds = value['_seconds'];

    if (seconds is num) {
      final nanoseconds = value['_nanoseconds'];

      return DateTime.fromMillisecondsSinceEpoch(
        seconds.toInt() * 1000 +
            ((nanoseconds is num ? nanoseconds.toInt() : 0) ~/ 1000000),
        isUtc: true,
      );
    }
  }

  return null;
}

int parseInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> stringList(dynamic value) {
  if (value is! List) return [];

  return value
      .map((e) => e.toString())
      .where((e) => e.isNotEmpty)
      .toList();
}