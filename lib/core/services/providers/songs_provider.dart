import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/modals/song.dart';
import 'package:musify/core/services/providers/user_data_provider.dart';

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
  final songs = ref.watch(songsProvider).valueOrNull ?? [];
  return {for (final song in songs) song.id: song};
});

// Recently played songs by user
final recentlyPlayedSongsProvider = Provider<List<Song>>((ref) {
  final userData = ref.watch(userDataProvider).valueOrNull;
  List recentlyPlayed = userData == null ? [] : userData.recentlyPlayed;
  Map<String, Song> songs = ref.watch(songsMapProvider);
  return recentlyPlayed.map((e) => songs[e]).whereType<Song>().toList();
});

// Recently played songs by user
final favouriteSongsProvider = Provider<List<Song>>((ref) {
  final userData = ref.watch(userDataProvider).valueOrNull;
  List favouriteSongs = userData == null ? [] : userData.favouriteSongs;
  Map<String, Song> songs = ref.watch(songsMapProvider);
  return favouriteSongs.map((e) => songs[e]).whereType<Song>().toList();
});
