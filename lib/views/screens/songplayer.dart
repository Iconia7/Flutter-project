import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class SongPlayerScreen extends StatefulWidget {
  final Map<String, String> song;

  const SongPlayerScreen({super.key, required this.song});

  @override
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isShuffleEnabled = false;
  bool _isLoopEnabled = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioSession();
    _loadSong();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
  }

  Future<void> _loadSong() async {
    try {
      await _audioPlayer.setAsset(widget.song['filePath']!);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffleEnabled = !_isShuffleEnabled;
      _audioPlayer.setShuffleModeEnabled(_isShuffleEnabled);
    });
  }

  void _toggleLoop() {
    setState(() {
      _isLoopEnabled = !_isLoopEnabled;
      _audioPlayer.setLoopMode(_isLoopEnabled ? LoopMode.one : LoopMode.off);
    });
  }

  void _playNext() {
    // Handle play next functionality if using a playlist
  }

  void _playPrevious() {
    // Handle play previous functionality if using a playlist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song['title'] ?? 'Now Playing'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 30),
            // Song Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.song['image']!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Song Title
            Text(
              widget.song['title'] ?? 'Song Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // Song Artist
            Text(
              widget.song['artist'] ?? 'Artist Name',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Audio Player Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48,
                  onPressed: _playPrevious,
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                  iconSize: 72,
                  color: Colors.deepPurpleAccent,
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 48,
                  onPressed: _playNext,
                ),
              ],
            ),
            SizedBox(height: 30),
            // Shuffle, Loop, and Equalizer Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shuffle,
                    color: _isShuffleEnabled ? Colors.deepPurpleAccent : Colors.grey,
                  ),
                  onPressed: _toggleShuffle,
                ),
                IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: _isLoopEnabled ? Colors.deepPurpleAccent : Colors.grey,
                  ),
                  onPressed: _toggleLoop,
                ),
                IconButton(
                  icon: Icon(Icons.equalizer),
                  color: Colors.grey,
                  onPressed: () {
                    // You can add an equalizer or audio settings here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
