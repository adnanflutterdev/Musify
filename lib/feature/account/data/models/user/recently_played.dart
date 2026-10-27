import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';

class RecentlyPlayed {
  final String songId;
  final DateTime playedAt;
  final bool completed;
  final int durationPlayed;

  RecentlyPlayed({
    required this.songId,
    required this.playedAt,
    required this.completed,
    required this.durationPlayed,
  });

  factory RecentlyPlayed.fromFirebase(Map<String, dynamic> recentlyPlayed) {
    return RecentlyPlayed(
      songId: recentlyPlayed['songId'],
      playedAt: parseDate(recentlyPlayed['playedAt']) ?? DateTime.now(),
      completed: recentlyPlayed['completed'] ?? true,
      durationPlayed: recentlyPlayed['durationPlayed'] ?? 0,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'songId': songId,
      'playedAt': Timestamp.fromDate(playedAt),
      'completed': completed,
      'durationPlayed': durationPlayed,
    };
  }

  static Map<String, dynamic> update({
    DateTime? playedAt,
    bool? completed,
    int? durationPlayed,
  }) {
    return {
      'playedAt': ?playedAt != null ? Timestamp.fromDate(playedAt) : null,
      'completed': ?completed,
      'durationPlayed': ?durationPlayed,
    };
  }
}

class RecentlyPlayedHistory {
  final String id;
  final String songId;
  final String? source;
  final String? sourceId;
  final bool completed;
  final int durationPlayed;
  final DateTime startedAt;
  final DateTime endedAt;

  RecentlyPlayedHistory({
    required this.id,
    required this.songId,
    this.source,
    this.sourceId,
    required this.completed,
    required this.durationPlayed,
    required this.startedAt,
    required this.endedAt,
  });

  factory RecentlyPlayedHistory.fromFirebase(Map<String, dynamic> history) {
    return RecentlyPlayedHistory(
      id: history['id'],
      songId: history['songId'],
      source: history['source'],
      sourceId: history['sourceId'],
      completed: history['completed'] ?? true,
      durationPlayed: history['durationPlayed'] ?? 0,
      startedAt: parseDate(history['startedAt']) ?? DateTime.now(),
      endedAt: parseDate(history['endedAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'songId': songId,
      'source': source,
      'sourceId': sourceId,
      'completed': completed,
      'durationPlayed': durationPlayed,
      'startedAt': Timestamp.fromDate(startedAt),
      'endedAt': Timestamp.fromDate(endedAt),
    };
  }
}

class LastPlayedSong {
  final String songId;
  final DateTime playedAt;
  final int duration;

  LastPlayedSong({
    required this.songId,
    required this.playedAt,
    required this.duration,
  });

  factory LastPlayedSong.fromString(String song) {
    final data = json.decode(song) as Map<String, dynamic>;

    return LastPlayedSong(
      songId: data['songId'],
      playedAt: DateTime.parse(data['playedAt']),
      duration: data['duration'] as int,
    );
  }

  String convertToString() {
    final data = {
      'songId': songId,
      'playedAt': playedAt.toIso8601String(),
      'duration': duration,
    };

    return json.encode(data);
  }
}
