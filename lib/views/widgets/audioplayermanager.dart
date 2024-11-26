import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();

  final AudioPlayer audioPlayer = AudioPlayer();
  Map<String, String> currentSong = {}; // Store title and image of the current song

  factory AudioPlayerManager() => _instance;

  AudioPlayerManager._internal();
}

