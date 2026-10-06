class AppDetails {
  final String name;
  final String version;
  final String minimumVersion;
  final String latestVersion;
  final bool forceUpdate;
  final String? updateUrl;

  const AppDetails({
    required this.name,
    required this.version,
    required this.minimumVersion,
    required this.latestVersion,
    required this.forceUpdate,
    this.updateUrl,
  });

  factory AppDetails.fromJson(Map<String, dynamic> json) {
    return AppDetails(
      name: json['name'] ?? 'Musify',
      version: json['version'] ?? '',
      minimumVersion: json['minimumVersion'] ?? '',
      latestVersion: json['latestVersion'] ?? '',
      forceUpdate: json['forceUpdate'] ?? false,
      updateUrl: json['updateUrl'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'version': version,
      'minimumVersion': minimumVersion,
      'latestVersion': latestVersion,
      'forceUpdate': forceUpdate,
      'updateUrl': updateUrl,
    };
  }
}