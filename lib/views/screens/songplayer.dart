import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:project/views/widgets/miniplayer.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


class SongPlayerScreen extends StatefulWidget {
  final Map<String, String> song;
  final List<Map<String, String>> playlist;

  const SongPlayerScreen(
      {super.key, required this.song, required this.playlist});

  @override
  // ignore: library_private_types_in_public_api
  _SongPlayerScreenState createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isShuffling = false;
  bool _isLooping = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioSession();
    _loadPlaylist();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
  }

  Future<void> _loadPlaylist() async {
    setState(() {
      _currentIndex = widget.playlist.indexWhere(
        (song) => song['title'] == widget.song['title'],
      );
    });
    await _loadSong();
  }

  Future<void> _loadSong() async {
    final currentSong = widget.playlist[_currentIndex];
    final songUrl = currentSong['url'];
    final filePath = currentSong['filePath'];

    try {
      if (songUrl != null) {
        // Fetch direct MP3 link from Tubidy (or similar search result)
        final response = await http.get(Uri.parse(songUrl));
        if (response.statusCode == 200) {
          final document = parse(response.body);
          final audioElement = document.querySelector('a[href*=".mp3"]');
          final audioUrl = audioElement?.attributes['href'];

          if (audioUrl != null) {
            await _audioPlayer.setUrl(audioUrl);
            _audioPlayer.play();
            setState(() => _isPlaying = true);
          } else {
            debugPrint('Error: Audio URL not found');
          }
        } else {
          debugPrint('Error: Failed to fetch song page');
        }
      } else if (filePath != null) {
        // Handle loading from assets or device storage
        if (filePath.startsWith('assets/')) {
          await _audioPlayer.setAsset(filePath);
        } else {
          await _audioPlayer.setFilePath(filePath);
        }
        _audioPlayer.play();
        setState(() => _isPlaying = true);
      } else {
        debugPrint('Error: No valid file path or URL found for the current song.');
      }
    } catch (e) {
      debugPrint("Error loading song: $e");
    }
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

  void _nextSong() {
    setState(() {
      if (_isShuffling) {
        _currentIndex =
            (widget.playlist.length * (1.0 * DateTime.now().millisecond / 1000))
                    .floor() %
                widget.playlist.length;
      } else {
        _currentIndex = (_currentIndex + 1) % widget.playlist.length;
      }
    });
    _loadSong();
  }

  void _previousSong() {
    setState(() {
      if (_isShuffling) {
        _currentIndex =
            (widget.playlist.length * (1.0 * DateTime.now().millisecond / 1000))
                    .floor() %
                widget.playlist.length;
      } else {
        _currentIndex = (_currentIndex - 1 + widget.playlist.length) %
            widget.playlist.length;
      }
    });
    _loadSong();
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffling = !_isShuffling;
      _audioPlayer.setShuffleModeEnabled(_isShuffling);
    });
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
      _audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = widget.playlist[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentSong['title'] ?? 'Now Playing'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 150),
          // Song Image
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                currentSong['image'] ?? 'assets/images/default_image.png',
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          // Audio Player Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Slider and Times
                StreamBuilder<Duration>(
                  stream: _audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final duration = _audioPlayer.duration ?? Duration.zero;

                    return Column(
                      children: [
                        Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0.0,
                          max: duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Text(
                                '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 0),
                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shuffle),
                      color: _isShuffling ? Colors.blue : Colors.grey,
                      iconSize: 36,
                      onPressed: _toggleShuffle,
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      color: Colors.blue,
                      iconSize: 48,
                      onPressed: _previousSong,
                    ),
                    IconButton(
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                      ),
                      color: Colors.blue,
                      iconSize: 72,
                      onPressed: _togglePlayPause,
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      color: Colors.blue,
                      iconSize: 48,
                      onPressed: _nextSong,
                    ),
                    IconButton(
                      icon: Icon(Icons.repeat),
                      color: _isLooping ? Colors.blue : Colors.grey,
                      iconSize: 36,
                      onPressed: _toggleLoop,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MiniPlayer(
              audioPlayer: _audioPlayer,
              songTitle: currentSong['title'] ?? '',
              songImage: currentSong['image'] ?? '',
            ),
          ),
        ],
      ),
      // MiniPlayer positioned at bottom
    );
  }
}
