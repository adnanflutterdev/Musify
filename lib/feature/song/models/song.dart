import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String url;
  final String songName;
  final String artistName;
  final String coverImage;
  final String date;
  final String language;
  final String movieName;
  final String songCategories;
  final int listen;
  final int duration;

  Song({
    required this.id,
    required this.url,
    required this.songName,
    required this.artistName,
    required this.coverImage,
    required this.date,
    required this.language,
    required this.movieName,
    required this.songCategories,
    required this.listen,
    required this.duration,
  });

  factory Song.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Song(
      id: doc.id,
      url: data['song'],
      songName: data['songName'],
      artistName: data['artistName'],
      coverImage: data['coverImage'],
      date: data['date'],
      language: data['language'],
      movieName: data['movieName'] ?? '',
      songCategories: data['songCategory'],
      listen: data['listen'],
      duration: data['duration'],
    );
  }
}
