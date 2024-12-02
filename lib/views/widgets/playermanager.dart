import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PlayerManager extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Map<String, String>? _currentSong;
  bool _isPlaying = false;

  AudioPlayer get audioPlayer => _audioPlayer;
  Map<String, String>? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  Future<void> playSong(Map<String, String> song) async {
    if (_currentSong != song) {
      _currentSong = song;
      final filePath = song['filePath'];
      if (filePath != null) {
        if (filePath.startsWith('assets/')) {
          await _audioPlayer.setAsset(filePath);
        } else {
          await _audioPlayer.setFilePath(filePath);
        }
      }
    }
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
