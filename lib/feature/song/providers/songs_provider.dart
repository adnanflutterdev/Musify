import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/feature/song/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final songsProvider = StreamProvider<List<Song>>((ref) {
  return FirebaseFirestore.instance
      .collection('Songs')
      .orderBy('songName')
      .snapshots()
      .map(
        (querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot doc) => Song.fromFirestore(doc))
            .toList(),
      );
});

final top20Songs = StreamProvider<List<Song>>((ref) {
  return FirebaseFirestore.instance
      .collection('Songs')
      .orderBy('listen', descending: true)
      .limit(20)
      .snapshots()
      .map(
        (querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot doc) => Song.fromFirestore(doc))
            .toList(),
      );
});

final songsMapProvider = Provider<Map<String, Song>>((ref) {
  final songs = ref.watch(songsProvider).value ?? [];
  return {for (final song in songs) song.id: song};
});

// Recently played songs by user
final recentlyPlayedSongsProvider = Provider<List<Song>>((ref) {
  // final userData = ref.watch(userDataProvider).value;
  List recentlyPlayed = [];
  // List recentlyPlayed = userData == null ? [] : userData.recentlyPlayed;
  Map<String, Song> songs = ref.watch(songsMapProvider);
  return recentlyPlayed.map((e) => songs[e]).whereType<Song>().toList();
});

// Recently played songs by user
final favouriteSongsProvider = Provider<List<Song>>((ref) {
  // final userData = ref.watch(userDataProvider).value;
  List favouriteSongs = [];
  // List favouriteSongs = userData == null ? [] : userData.favouriteSongs;
  Map<String, Song> songs = ref.watch(songsMapProvider);
  return favouriteSongs.map((e) => songs[e]).whereType<Song>().toList();
});

Future<List<Map<String, dynamic>>> getSongs() async {
  final data =
      await FirebaseFirestore.instance.collection('Songs').get();

  return data.docs.map((song) {
    return {
      'id': song.id,
      ...song.data(),
    };
  }).toList();
}

Future<void> downloadSongsJson() async {
  // Get all songs from Firestore
  final songs = await getSongs();

  // Convert List<Map> to formatted JSON
  final jsonText = const JsonEncoder.withIndent('  ').convert(songs);

  // Get app documents directory
  final directory = await getApplicationDocumentsDirectory();

  // Create JSON file
  final file = File('${directory.path}/songs.json');

  // Write JSON to file
  await file.writeAsString(jsonText);
}
