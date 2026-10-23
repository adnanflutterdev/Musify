import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/feature/song/data/models/new_song.dart';

class SongsDataSource {
  final FirebaseFirestore firestore;

  SongsDataSource(this.firestore);

  DocumentSnapshot<Map<String, dynamic>>? _lastDocument;

  Future<List<Song>> loadSongs(int limit) async {
    Query<Map<String, dynamic>> query = firestore
        .collection('songs')
        .orderBy('title')
        .limit(limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final songs = await query.get();

    if (songs.docs.isNotEmpty) {
      _lastDocument = songs.docs.last;
    }

    return songs.docs.map((song) => Song.fromFirebase(song.data())).toList();
  }

  Future<void> addSongCount()async{
    
  }
}
