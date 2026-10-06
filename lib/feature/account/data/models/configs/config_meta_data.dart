import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';

class ConfigMetadata {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ConfigMetadata({
    this.createdAt,
    this.updatedAt,
  });

  factory ConfigMetadata.fromJson(Map<String, dynamic> json) {
    return ConfigMetadata(
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : null,
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : null,
    };
  }
}