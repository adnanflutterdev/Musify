import 'package:flutter/material.dart';
import 'package:musify/core/utils/text.dart';

class LibraryTab extends StatefulWidget {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  // Future<void> _uploadSong() async {
  //   for (Map<String, dynamic> song in songs) {
  //     await FirebaseFirestore.instance.collection("Songs").add(song);
  //     print(song['songName']);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(child: whiteTextMedium('COMING SOON...'));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: IconButton(
  //       onPressed: () {
  //         _uploadSong();
  //       },
  //       icon: Icon(Icons.upload, color: Colors.white, size: 40),
  //     ),
  //   );
  // }
}
