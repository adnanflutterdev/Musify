import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';
import 'package:musify/feature/account/data/models/configs/app_details.dart';
import 'package:musify/feature/account/data/models/configs/app_limits.dart';
import 'package:musify/feature/account/data/models/configs/config_meta_data.dart';
import 'package:musify/feature/account/data/models/configs/feature.dart';
import 'package:musify/feature/account/data/models/configs/subscription.dart';

class AppConfig {
  final AppDetails app;
  final SubscriptionConfig subscription;
  final MaintenanceConfig maintenance;
  final FeatureConfig features;
  final AppLimits limits;
  final ConfigMetadata metadata;

  const AppConfig({
    required this.app,
    required this.subscription,
    required this.maintenance,
    required this.features,
    required this.limits,
    required this.metadata,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      app: AppDetails.fromJson(Map<String, dynamic>.from(json['app'] ?? {})),
      subscription: SubscriptionConfig.fromJson(
        Map<String, dynamic>.from(json['subscription'] ?? {}),
      ),
      maintenance: MaintenanceConfig.fromJson(
        Map<String, dynamic>.from(json['maintenance'] ?? {}),
      ),
      features: FeatureConfig.fromJson(
        Map<String, dynamic>.from(json['features'] ?? {}),
      ),
      limits: AppLimits.fromJson(
        Map<String, dynamic>.from(json['limits'] ?? {}),
      ),
      metadata: ConfigMetadata.fromJson(
        Map<String, dynamic>.from(json['metadata'] ?? {}),
      ),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'app': app.toFirebase(),
      'subscription': subscription.toFirebase(),
      'maintenance': maintenance.toFirebase(),
      'features': features.toFirebase(),
      'limits': limits.toFirebase(),
      'metadata': metadata.toFirebase(),
    };
  }
}

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
      'startAt': startAt != null ? Timestamp.fromDate(startAt!) : null,
      'endAt': endAt != null ? Timestamp.fromDate(endAt!) : null,
      'allowExistingUsers': allowExistingUsers,
      'allowLogin': allowLogin,
      'minimumAppVersion': minimumAppVersion,
    };
  }
}
