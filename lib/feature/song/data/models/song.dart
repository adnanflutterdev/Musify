import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String title;
  final String slug;

  /// References to artists, optionally including cached display names.
  final List<Artist> artists;

  /// Album may be null for standalone singles.
  final AlbumDetails? album;

  final Release release;
  final Media media;
  final Classification classification;
  final ContextDetails context;
  final Stats stats;
  final Flags flags;
  final Metadata metadata;

  String getArtists() {
    if (artists.isEmpty) return '';

    if (artists.length == 1) return artists.first.name;

    if (artists.length == 2) return artistList.join(' and ');

    return '${artistList.sublist(0, artistList.length - 1).join(', ')} and ${artistList.last}';
  }

  List<String> get artistList => artists.map((a) => a.name).toList();

  const Song({
    required this.id,
    required this.title,
    required this.slug,
    this.artists = const [],
    this.album,
    required this.release,
    required this.media,
    required this.classification,
    required this.context,
    this.stats = const Stats(),
    this.flags = const Flags(),
    this.metadata = const Metadata(),
  });

  factory Song.fromFirebase(Map<String, dynamic> json) {
    return Song(
      id: _string(json['id']),
      title: _string(json['title']),
      slug: _string(json['slug']),
      artists: _mapList(json['artists'])
          .map(Artist.fromJson)
          .toList(growable: false),
      album: json['album'] is Map
          ? AlbumDetails.fromJson(_map(json['album']))
          : json['albumId'] is String
          ? AlbumDetails(id: json['albumId'] as String, name: '')
          : null,
      release: Release.fromJson(_map(json['release'])),
      media: Media.fromJson(_map(json['media'])),
      classification: Classification.fromJson(_map(json['classification'])),
      context: ContextDetails.fromJson(_map(json['context'])),
      stats: Stats.fromJson(_map(json['stats'])),
      flags: Flags.fromJson(_map(json['flags'])),
      metadata: Metadata.fromJson(_map(json['metadata'])),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'artists': artists.map((e) => e.toFirebase()).toList(),
      'album': album?.toFirebase(),
      'release': release.toFirebase(),
      'media': media.toFirebase(),
      'classification': classification.toFirebase(),
      'context': context.toFirebase(),
      'stats': stats.toFirebase(),
      'flags': flags.toFirebase(),
      'metadata': metadata.toFirebase(),
    };
  }

  /// Use this for immutable updates without reconstructing every field.
  Song copyWith({
    String? id,
    String? title,
    String? slug,
    List<Artist>? artists,
    AlbumDetails? album,
    bool clearAlbum = false,
    Release? release,
    Media? media,
    Classification? classification,
    ContextDetails? context,
    Stats? stats,
    Flags? flags,
    Metadata? metadata,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      artists: artists ?? this.artists,
      album: clearAlbum ? null : (album ?? this.album),
      release: release ?? this.release,
      media: media ?? this.media,
      classification: classification ?? this.classification,
      context: context ?? this.context,
      stats: stats ?? this.stats,
      flags: flags ?? this.flags,
      metadata: metadata ?? this.metadata,
    );
  }
}

// -----------------------------------------------------------------------------
// ARTIST
// -----------------------------------------------------------------------------

class Artist {
  /// References artists/{id} in Firestore.
  final String id;

  /// Optional denormalized name for convenient song-list rendering.
  final String name;

  /// Examples: primary, featured, remixer.
  final String role;

  const Artist({required this.id, this.name = '', this.role = 'primary'});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: _string(json['artistId'] ?? json['id']),
      name: _string(json['name']),
      role: _string(json['role'], fallback: 'primary'),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'artistId': id,
    if (name.isNotEmpty) 'name': name,
    'role': role,
  };
}

// -----------------------------------------------------------------------------
// ALBUM
// -----------------------------------------------------------------------------

class AlbumDetails {
  /// References albums/{id} in Firestore.
  final String id;

  /// Optional cached title.
  final String name;

  const AlbumDetails({required this.id, this.name = ''});

  factory AlbumDetails.fromJson(Map<String, dynamic> json) {
    return AlbumDetails(
      id: _string(json['albumId'] ?? json['id']),
      name: _string(json['name'] ?? json['title']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'albumId': id,
    if (name.isNotEmpty) 'name': name,
  };
}

// -----------------------------------------------------------------------------
// RELEASE
// -----------------------------------------------------------------------------

class Release {
  /// Null when the exact release date is unknown.
  final DateTime? releaseDate;

  /// Useful when only a year is known.
  final int? year;

  /// Examples: single, album, EP, compilation.
  final String type;

  const Release({this.releaseDate, this.year, this.type = 'single'});

  /// Derive year from the exact date when available.
  int? get effectiveYear => releaseDate?.year ?? year;

  /// Derived rather than stored to avoid inconsistent values.
  String? get decade {
    final value = effectiveYear;
    return value == null ? null : '${(value ~/ 10) * 10}s';
  }

  factory Release.fromJson(Map<String, dynamic> json) {
    final date = _date(json['releaseDate']);

    return Release(
      releaseDate: date,
      year: date?.year ?? _nullableInt(json['year']),
      type: _string(json['type'], fallback: 'single'),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'releaseDate': releaseDate == null
        ? null
        : Timestamp.fromDate(releaseDate!),
    'year': effectiveYear,
    'type': type,
  };
}

// -----------------------------------------------------------------------------
// MEDIA
// -----------------------------------------------------------------------------

class Media {
  /// Default playable audio URL.
  final String audioUrl;

  /// Duration in seconds.
  final int duration;

  final String coverImage;

  /// Optional additional audio encodings or quality variants.
  final List<AudioSourceData> audioSources;

  const Media({
    required this.audioUrl,
    required this.duration,
    required this.coverImage,
    this.audioSources = const [],
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      audioUrl: _string(json['audioUrl']),
      duration: _int(json['duration']),
      coverImage: _string(json['coverImage']),
      audioSources: _mapList(json['audioSources'])
          .map(AudioSourceData.fromJson)
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'audioUrl': audioUrl,
    'duration': duration,
    'coverImage': coverImage,
    if (audioSources.isNotEmpty)
      'audioSources': audioSources.map((e) => e.toFirebase()).toList(),
  };
}

class AudioSourceData {
  final String url;
  final String format;
  final String quality;
  final int? bitrate;

  const AudioSourceData({
    required this.url,
    required this.format,
    required this.quality,
    this.bitrate,
  });

  factory AudioSourceData.fromJson(Map<String, dynamic> json) {
    return AudioSourceData(
      url: _string(json['url']),
      format: _string(json['format']),
      quality: _string(json['quality']),
      bitrate: _nullableInt(json['bitrate']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'url': url,
    'format': format,
    'quality': quality,
    if (bitrate != null) 'bitrate': bitrate,
  };
}

// -----------------------------------------------------------------------------
// CLASSIFICATION
// -----------------------------------------------------------------------------

class Classification {
  final List<String> genres;
  final List<String> moods;
  final List<String> languages;
  final List<String> tags;

  const Classification({
    this.genres = const [],
    this.moods = const [],
    this.languages = const [],
    this.tags = const [],
  });

  factory Classification.fromJson(Map<String, dynamic> json) {
    return Classification(
      genres: _stringList(json['genres']),
      moods: _stringList(json['moods']),
      languages: _stringList(json['languages']),
      tags: _stringList(json['tags']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'genres': genres,
    'moods': moods,
    'languages': languages,
    'tags': tags,
  };
}

// -----------------------------------------------------------------------------
// CONTEXT / SOUNDTRACK
// -----------------------------------------------------------------------------

class ContextDetails {
  final MovieDetails? movie;
  final bool isSoundtrack;

  const ContextDetails({this.movie, this.isSoundtrack = false});

  factory ContextDetails.fromJson(Map<String, dynamic> json) {
    return ContextDetails(
      movie: json['movie'] is Map
          ? MovieDetails.fromJson(_map(json['movie']))
          : null,
      isSoundtrack: _bool(json['isSoundtrack']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'movie': movie?.toFirebase(),
    'isSoundtrack': isSoundtrack,
  };
}

class MovieDetails {
  final String id;
  final String name;

  const MovieDetails({required this.id, required this.name});

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: _string(json['movieId'] ?? json['id']),
      name: _string(json['name'] ?? json['title']),
    );
  }

  Map<String, dynamic> toFirebase() => {'movieId': id, 'name': name};
}

// -----------------------------------------------------------------------------
// STATISTICS
// -----------------------------------------------------------------------------

class Stats {
  final int playCount;
  final int likeCount;
  final int shareCount;
  final int downloadCount;

  const Stats({
    this.playCount = 0,
    this.likeCount = 0,
    this.shareCount = 0,
    this.downloadCount = 0,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      playCount: _int(json['playCount']),
      likeCount: _int(json['likeCount']),
      shareCount: _int(json['shareCount']),
      downloadCount: _int(json['downloadCount']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'playCount': playCount,
    'likeCount': likeCount,
    'shareCount': shareCount,
    'downloadCount': downloadCount,
  };
}

// -----------------------------------------------------------------------------
// FLAGS
// -----------------------------------------------------------------------------

class Flags {
  final bool isExplicit;

  /// Manually curated feature status.
  final bool isFeatured;

  /// Cached/managed status; not a permanent property of the song.
  final bool isTrending;

  /// Cached/managed status; derive from release date when appropriate.
  final bool isNewRelease;

  const Flags({
    this.isExplicit = false,
    this.isFeatured = false,
    this.isTrending = false,
    this.isNewRelease = false,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      isExplicit: _bool(json['isExplicit']),
      isFeatured: _bool(json['isFeatured']),
      isTrending: _bool(json['isTrending']),
      isNewRelease: _bool(json['isNewRelease']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'isExplicit': isExplicit,
    'isFeatured': isFeatured,
    'isTrending': isTrending,
    'isNewRelease': isNewRelease,
  };
}

// -----------------------------------------------------------------------------
// METADATA
// -----------------------------------------------------------------------------

class Metadata {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Metadata({this.createdAt, this.updatedAt});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      createdAt: _date(json['createdAt']),
      updatedAt: _date(json['updatedAt']),
    );
  }

  Map<String, dynamic> toFirebase() => {
    'createdAt': createdAt == null ? null : Timestamp.fromDate(createdAt!),
    'updatedAt': updatedAt == null ? null : Timestamp.fromDate(updatedAt!),
  };
}

// -----------------------------------------------------------------------------
// SAFE PARSING HELPERS
// -----------------------------------------------------------------------------

Map<String, dynamic> _map(dynamic value) {
  if (value is Map<String, dynamic>) return value;

  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }

  return <String, dynamic>{};
}

List<Map<String, dynamic>> _mapList(dynamic value) {
  if (value is! List) return const [];

  return value.whereType<Map>().map(_map).toList(growable: false);
}

String _string(dynamic value, {String fallback = ''}) {
  if (value == null) return fallback;
  return value is String ? value : value.toString();
}

int _int(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

int? _nullableInt(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

bool _bool(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    return value.toLowerCase() == 'true';
  }
  return false;
}

List<String> _stringList(dynamic value) {
  if (value is! List) return const [];

  return value
      .where((item) => item != null)
      .map((item) => item.toString().trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
}

DateTime? _date(dynamic value) {
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

  // Supports JSON timestamp representations from external exports.
  if (value is Map) {
    final map = _map(value);
    final seconds = map['_seconds'] ?? map['seconds'];
    final nanos = map['_nanoseconds'] ?? map['nanoseconds'];

    if (seconds is num) {
      final nanoseconds = nanos is num ? nanos.toInt() : 0;

      return DateTime.fromMicrosecondsSinceEpoch(
        seconds.toInt() * Duration.microsecondsPerSecond + nanoseconds ~/ 1000,
        isUtc: true,
      );
    }
  }

  return null;
}
