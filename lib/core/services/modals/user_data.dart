import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String dob;
  final String name;
  final String image;
  final String gender;
  final List myAlbumn;
  final List myPlaylists;
  final List favouriteSongs;
  final List recentlyPlayed;

  UserData({
    required this.dob,
    required this.name,
    required this.image,
    required this.gender,
    required this.myAlbumn,
    required this.myPlaylists,
    required this.favouriteSongs,
    required this.recentlyPlayed,
  });

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    final myData = doc.data() as Map<String, dynamic>;
    return UserData(
      dob: myData['dob'] ?? '',
      name: myData['name'] ?? '',
      image: myData['image'] ?? '',
      gender: myData['gender'] ?? '',
      myAlbumn: myData['myAlbumn'] ?? [],
      myPlaylists: myData['myPlaylists'] ?? [],
      favouriteSongs: myData['favourite'] ?? [],
      recentlyPlayed: myData['recentlyPlayed'] ?? [],
    );
  }
}
