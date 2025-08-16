import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/functions/play_song.dart';
import 'package:musify/screens/song_details_screen.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/audio_player_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/duration_label.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/text.dart';

class SongTile extends ConsumerWidget {
  const SongTile({super.key, required this.song, required this.isSameSong});
  final Song song;
  final bool isSameSong;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioProvider = ref.watch(audioPlayerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        color: isSameSong ? AppColors.primaryPink : Colors.transparent,
        child: ListTile(
          onTap: () {
            isSameSong
                ? null
                : playSong(song: song, audioProvider: audioProvider);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          minTileHeight: 45,
          horizontalTitleGap: 8,
          leading: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongDetailsScreen(song: song),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: song.coverImage,
              placeholder: (context, url) => CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(coverImage),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(coverImage),
              ),
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(radius: 20, backgroundImage: imageProvider),
            ),
          ),
          title: tileTitle(song.songName),
          subtitle: tileSubTitle(song.artistName),
          trailing: tileTrailing(durationLabel(song.duration)),
        ),
      ),
    );
  }
}
