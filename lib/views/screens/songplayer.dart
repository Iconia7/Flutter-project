import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SongPlayer extends StatefulWidget {
  final String songTitle;
  final String imagePath;
  final List<String> songQueue; // Queue of song URLs

  const SongPlayer({
    super.key,
    required this.songTitle,
    required this.imagePath,
    required this.songQueue,
  });

  @override
  _SongPlayerState createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isFavorite = false;
  Duration currentPosition = Duration.zero;
  Duration songDuration = Duration.zero;
  int currentSongIndex = 0;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        songDuration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        currentPosition = newPosition;
      });
    });

    // Load and play the first song in the queue (or the only song)
    if (widget.songQueue.isNotEmpty) {
      _loadSong(widget.songQueue[currentSongIndex]).then((_) {
        _audioPlayer.resume(); // Start playback immediately
      });
    } else {
      print("songQueue is empty");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadSong(String path) async {
    if (path.startsWith('assets/')) {
      // Load from assets if it's an asset path
      await _audioPlayer.setSourceAsset(path);
    } else {
      // Otherwise, treat it as a URL
      await _audioPlayer.setSourceUrl(path);
    }
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  Future<void> _skipForward() async {
    await _audioPlayer.seek(currentPosition + const Duration(seconds: 10));
  }

  Future<void> _skipBackward() async {
    await _audioPlayer.seek(currentPosition - const Duration(seconds: 10));
  }

  Future<void> _nextSong() async {
    if (currentSongIndex < widget.songQueue.length - 1) {
      currentSongIndex++;
      await _loadSong(widget.songQueue[currentSongIndex]);
    }
  }

  Future<void> _previousSong() async {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      await _loadSong(widget.songQueue[currentSongIndex]);
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      // Save to local storage here if needed
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.songTitle,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Song Cover
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Equalizer Placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Equalizer', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(width: 10),
                Icon(Icons.equalizer, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            // Progress and Seekbar
            Slider(
              min: 0,
              max: songDuration.inSeconds.toDouble(),
              value: currentPosition.inSeconds
                  .toDouble()
                  .clamp(0, songDuration.inSeconds.toDouble()),
              onChanged: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
            ),

            // Current Time / Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(currentPosition),
                    style: TextStyle(color: Colors.grey[700])),
                Text(_formatDuration(songDuration),
                    style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            const SizedBox(height: 30),

            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: _previousSong,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: _skipBackward,
                ),
                InkWell(
                  onTap: _playPauseAudio,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.green,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: _skipForward,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: _nextSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
