import 'package:musify/feature/account/data/models/configs/app_details.dart';
import 'package:musify/feature/account/data/models/configs/app_limits.dart';
import 'package:musify/feature/account/data/models/configs/config_meta_data.dart';
import 'package:musify/feature/account/data/models/configs/feature.dart';
import 'package:musify/feature/account/data/models/configs/maintenace.dart';
import 'package:musify/feature/account/data/models/configs/subscription.dart';

class GeneralConfigs {
  final AppDetails app;
  final SubscriptionConfig subscription;
  final MaintenanceConfig maintenance;
  final FeatureConfig features;
  final AppLimits limits;
  final ConfigMetadata metadata;

  const GeneralConfigs({
    required this.app,
    required this.subscription,
    required this.maintenance,
    required this.features,
    required this.limits,
    required this.metadata,
  });

  factory GeneralConfigs.fromJson(Map<String, dynamic> json) {
    return GeneralConfigs(
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

