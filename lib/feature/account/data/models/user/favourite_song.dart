import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';

class FavouriteSong {
  final String songId;
  final DateTime createdAt;

  FavouriteSong({required this.songId, required this.createdAt});

  factory FavouriteSong.fromFirebase(Map<String, dynamic> favourite) {
    return FavouriteSong(
      songId: favourite['songId'],
      createdAt: parseDate(favourite['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {'songId': songId, 'createdAt': Timestamp.fromDate(createdAt)};
  }

}
