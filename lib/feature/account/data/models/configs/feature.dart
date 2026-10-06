class FeatureConfig {
  final bool downloads;
  final bool offlineMode;
  final bool lyrics;
  final bool equalizer;
  final bool social;
  final bool comments;
  final bool sharing;
  final bool recommendations;

  const FeatureConfig({
    required this.downloads,
    required this.offlineMode,
    required this.lyrics,
    required this.equalizer,
    required this.social,
    required this.comments,
    required this.sharing,
    required this.recommendations,
  });

  factory FeatureConfig.fromJson(Map<String, dynamic> json) {
    return FeatureConfig(
      downloads: json['downloads'] ?? false,
      offlineMode: json['offlineMode'] ?? false,
      lyrics: json['lyrics'] ?? false,
      equalizer: json['equalizer'] ?? false,
      social: json['social'] ?? false,
      comments: json['comments'] ?? false,
      sharing: json['sharing'] ?? false,
      recommendations: json['recommendations'] ?? false,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'downloads': downloads,
      'offlineMode': offlineMode,
      'lyrics': lyrics,
      'equalizer': equalizer,
      'social': social,
      'comments': comments,
      'sharing': sharing,
      'recommendations': recommendations,
    };
  }
}