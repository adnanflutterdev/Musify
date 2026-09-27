import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String title;
  final String slug;
  final List<Artist> artists;
  final AlbumDetails? album;
  final Release release;
  final Media media;
  final Classification classification;
  final ContextDetails context;
  final Stats stats;
  final Flags flags;
  final Metadata metadata;

  const Song({
    required this.id,
    required this.title,
    required this.slug,
    required this.artists,
    this.album,
    required this.release,
    required this.media,
    required this.classification,
    required this.context,
    required this.stats,
    required this.flags,
    required this.metadata,
  });

  factory Song.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Song.fromJson({
      ...data,
      'id': data['id'] ?? doc.id,
    });
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      artists: (json['artists'] as List?)
              ?.map((e) => Artist.fromJson(
                    Map<String, dynamic>.from(e),
                  ))
              .toList() ??
          [],
      album: json['album'] != null
          ? AlbumDetails.fromJson(
              Map<String, dynamic>.from(json['album']),
            )
          : null,
      release: Release.fromJson(
        Map<String, dynamic>.from(json['release'] ?? {}),
      ),
      media: Media.fromJson(
        Map<String, dynamic>.from(json['media'] ?? {}),
      ),
      classification: Classification.fromJson(
        Map<String, dynamic>.from(json['classification'] ?? {}),
      ),
      context: ContextDetails.fromJson(
        Map<String, dynamic>.from(json['context'] ?? {}),
      ),
      stats: Stats.fromJson(
        Map<String, dynamic>.from(json['stats'] ?? {}),
      ),
      flags: Flags.fromJson(
        Map<String, dynamic>.from(json['flags'] ?? {}),
      ),
      metadata: Metadata.fromJson(
        Map<String, dynamic>.from(json['metadata'] ?? {}),
      ),
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
}

class Artist {
  final String id;
  final String name;
  final String role;

  const Artist({
    required this.id,
    required this.name,
    required this.role,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'artist',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'name': name,
      'role': role,
    };
  }
}class AlbumDetails {
  final String id;
  final String name;

  const AlbumDetails({
    required this.id,
    required this.name,
  });

  factory AlbumDetails.fromJson(Map<String, dynamic> json) {
    return AlbumDetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'name': name,
    };
  }
}class Release {
  final DateTime? releaseDate;
  final int year;
  final String? decade;
  final String type;

  const Release({
    this.releaseDate,
    required this.year,
    this.decade,
    required this.type,
  });

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      releaseDate: _parseDate(json['releaseDate']),
      year: _parseInt(json['year']),
      decade: json['decade'],
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'releaseDate': releaseDate != null
          ? Timestamp.fromDate(releaseDate!)
          : null,
      'year': year,
      'decade': decade,
      'type': type,
    };
  }
}class Media {
  final String audioUrl;
  final int duration;
  final String coverImage;

  const Media({
    required this.audioUrl,
    required this.duration,
    required this.coverImage,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      audioUrl: json['audioUrl'] ?? '',
      duration: _parseInt(json['duration']),
      coverImage: json['coverImage'] ?? '',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'audioUrl': audioUrl,
      'duration': duration,
      'coverImage': coverImage,
    };
  }
}class Classification {
  final List<String> genres;
  final List<String> moods;
  final List<String> languages;
  final List<String> tags;

  const Classification({
    required this.genres,
    required this.moods,
    required this.languages,
    required this.tags,
  });

  factory Classification.fromJson(Map<String, dynamic> json) {
    return Classification(
      genres: _stringList(json['genres']),
      moods: _stringList(json['moods']),
      languages: _stringList(json['languages']),
      tags: _stringList(json['tags']),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'genres': genres,
      'moods': moods,
      'languages': languages,
      'tags': tags,
    };
  }
}class ContextDetails {
  final MovieDetails? movie;
  final bool isSoundtrack;

  const ContextDetails({
    this.movie,
    required this.isSoundtrack,
  });

  factory ContextDetails.fromJson(Map<String, dynamic> json) {
    return ContextDetails(
      movie: json['movie'] != null
          ? MovieDetails.fromJson(
              Map<String, dynamic>.from(json['movie']),
            )
          : null,
      isSoundtrack: json['isSoundtrack'] ?? false,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'movie': movie?.toFirebase(),
      'isSoundtrack': isSoundtrack,
    };
  }
}class MovieDetails {
  final String id;
  final String name;

  const MovieDetails({
    required this.id,
    required this.name,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'name': name,
    };
  }
}class Stats {
  final int playCount;
  final int likeCount;
  final int shareCount;
  final int downloadCount;

  const Stats({
    required this.playCount,
    required this.likeCount,
    required this.shareCount,
    required this.downloadCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      playCount: _parseInt(json['playCount']),
      likeCount: _parseInt(json['likeCount']),
      shareCount: _parseInt(json['shareCount']),
      downloadCount: _parseInt(json['downloadCount']),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'playCount': playCount,
      'likeCount': likeCount,
      'shareCount': shareCount,
      'downloadCount': downloadCount,
    };
  }
}class Flags {
  final bool isExplicit;
  final bool isFeatured;
  final bool isTrending;
  final bool isNewRelease;

  const Flags({
    required this.isExplicit,
    required this.isFeatured,
    required this.isTrending,
    required this.isNewRelease,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      isExplicit: json['isExplicit'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      isTrending: json['isTrending'] ?? false,
      isNewRelease: json['isNewRelease'] ?? false,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'isExplicit': isExplicit,
      'isFeatured': isFeatured,
      'isTrending': isTrending,
      'isNewRelease': isNewRelease,
    };
  }
}class Metadata {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Metadata({
    this.createdAt,
    this.updatedAt,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
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

DateTime? _parseDate(dynamic value) {
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

  // Supports JSON representation:
  // {
  //   "_seconds": 1234567890,
  //   "_nanoseconds": 0
  // }
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

int _parseInt(dynamic value) {
  if (value == null) return 0;

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString()) ?? 0;
}

List<String> _stringList(dynamic value) {
  if (value == null) return [];

  if (value is List) {
    return value
        .map((e) => e.toString())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  return [];
}