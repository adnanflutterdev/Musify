import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';

class MaintenanceConfig {
  final bool enabled;
  final String title;
  final String message;
  final String? imageUrl;
  final DateTime? startAt;
  final DateTime? endAt;
  final bool allowExistingUsers;
  final bool allowLogin;
  final String? minimumAppVersion;

  const MaintenanceConfig({
    required this.enabled,
    required this.title,
    required this.message,
    this.imageUrl,
    this.startAt,
    this.endAt,
    required this.allowExistingUsers,
    required this.allowLogin,
    this.minimumAppVersion,
  });

  factory MaintenanceConfig.fromJson(Map<String, dynamic> json) {
    return MaintenanceConfig(
      enabled: json['enabled'] ?? false,
      title: json['title'] ?? 'Under Maintenance',
      message: json['message'] ?? '',
      imageUrl: json['imageUrl'],
      startAt: parseDate(json['startAt']),
      endAt: parseDate(json['endAt']),
      allowExistingUsers: json['allowExistingUsers'] ?? false,
      allowLogin: json['allowLogin'] ?? true,
      minimumAppVersion: json['minimumAppVersion'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'enabled': enabled,
      'title': title,
      'message': message,
      'imageUrl': imageUrl,
      'startAt': startAt != null
          ? Timestamp.fromDate(startAt!)
          : null,
      'endAt': endAt != null
          ? Timestamp.fromDate(endAt!)
          : null,
      'allowExistingUsers': allowExistingUsers,
      'allowLogin': allowLogin,
      'minimumAppVersion': minimumAppVersion,
    };
  }
}