class Avatar {
  final bool enabled;
  final List<AvatarData> avatars;

  Avatar({required this.enabled, required this.avatars});

  factory Avatar.fromFirebase(Map<String, dynamic> data) {
    return Avatar(
      enabled: data['enabled'],
      avatars: (data['avatars'] as List<dynamic>)
          .map((a) => AvatarData.fromFirebase(a as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'enabled': enabled,
      'avatars': avatars.map((a) => a.toFirebase).toList(),
    };
  }
}

class AvatarData {
  final String id;
  final String name;
  final String url;
  final bool isActive;

  const AvatarData({
    required this.id,
    required this.name,
    required this.url,
    required this.isActive,
  });

  factory AvatarData.fromFirebase(Map<String, dynamic> json) {
    return AvatarData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {'id': id, 'name': name, 'url': url, 'isActive': isActive};
  }
}
