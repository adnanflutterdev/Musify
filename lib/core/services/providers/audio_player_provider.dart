import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/main.dart';
import 'package:musify/core/services/audio/audio_player_handler.dart';

final audioPlayerProvider = Provider<AudioPlayerHandler>((ref) => audioHandler);
