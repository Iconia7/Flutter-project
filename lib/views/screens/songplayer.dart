import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class SongPlayer extends StatefulWidget {
  final String songTitle;

  const SongPlayer({super.key, required this.songTitle, required String imagePath});

  @override
  _SongPlayerState createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration songDuration = Duration.zero;
  String? localSongPath;

  @override
  void initState() {
    super.initState();

    // Set up listeners for audio position and duration
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() => currentPosition = position);
    });
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => songDuration = duration);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else if (localSongPath != null) {
      await _audioPlayer.play(DeviceFileSource(localSongPath!));
    } else {
      await _selectLocalSong();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  Future<void> _selectLocalSong() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      localSongPath = result.files.single.path;
      await _audioPlayer.play(DeviceFileSource(localSongPath!));
      setState(() {
        isPlaying = true;
      });
    } else {
      // User canceled the picker
      setState(() {
        isPlaying = false;
      });
    }
  }

  Future<void> _seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
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
          style: GoogleFonts.notoSerif(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Song Cover Placeholder
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(Icons.music_note, size: 100, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Song Title
            Text(
              widget.songTitle,
              style: GoogleFonts.notoSerif(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Progress and Seekbar
            Slider(
              min: 0,
              max: songDuration.inSeconds.toDouble(),
              value: currentPosition.inSeconds.toDouble().clamp(0, songDuration.inSeconds.toDouble()),
              onChanged: (value) {
                _seekAudio(Duration(seconds: value.toInt()));
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
            ),

            // Current Time / Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(currentPosition),
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  _formatDuration(songDuration),
                  style: TextStyle(color: Colors.grey[700]),
                ),
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
                  onPressed: () {
                    // Simulate previous song
                  },
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
                  icon: const Icon(Icons.skip_next),
                  iconSize: 50,
                  color: Colors.green,
                  onPressed: () {
                    // Simulate next song
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
