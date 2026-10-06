import 'package:musify/core/utils/model_helper.dart';

class SubscriptionConfig {
  final bool enabled;
  final String currency;
  final List<SubscriptionPlan> plans;

  const SubscriptionConfig({
    required this.enabled,
    required this.currency,
    required this.plans,
  });

  factory SubscriptionConfig.fromJson(Map<String, dynamic> json) {
    return SubscriptionConfig(
      enabled: json['enabled'] ?? false,
      currency: json['currency'] ?? 'INR',
      plans: (json['plans'] as List?)
              ?.map(
                (e) => SubscriptionPlan.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'enabled': enabled,
      'currency': currency,
      'plans': plans.map((e) => e.toFirebase()).toList(),
    };
  }
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String billingPeriod;
  final bool isPopular;
  final bool isActive;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.billingPeriod,
    required this.isPopular,
    required this.isActive,
    required this.features,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      billingPeriod: json['billingPeriod'] ?? '',
      isPopular: json['isPopular'] ?? false,
      isActive: json['isActive'] ?? true,
      features: stringList(json['features']),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'billingPeriod': billingPeriod,
      'isPopular': isPopular,
      'isActive': isActive,
      'features': features,
    };
  }
}