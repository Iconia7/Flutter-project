import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<FileSystemEntity> _songs = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLoadSongs();
  }

  /// Requests storage permission and loads songs.
  Future<void> _requestPermissionAndLoadSongs() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      await _loadSongs();
    } else {
      // Show a message if permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Storage permission is required to access songs.')),
      );
    }
  }

  /// Loads songs from the "Music" directory.
  Future<void> _loadSongs() async {
    try {
      final directories =
          await getExternalStorageDirectories(type: StorageDirectory.music);
      if (directories == null || directories.isEmpty) {
        debugPrint('No accessible music directories found.');
        return;
      }

      // Access the first music directory found
      final musicDirectory = directories.first;
      final songsDir = Directory(musicDirectory.path);
      final files =
          songsDir.listSync().where((file) => file.path.endsWith('.mp3'));

      setState(() {
        _songs = files.toList();
      });

      if (_songs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No MP3 files found in the Music directory.')),
        );
      }
    } catch (e) {
      debugPrint('Error loading songs: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to load songs. Please try again.')),
      );
    }
  }

  /// Plays the selected song.
  Future<void> _playSong(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing song: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to play the selected song.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                return ListTile(
                  leading: const Icon(
                    Icons.music_note,
                    color: Colors.brown,
                    size: 40,
                  ),
                  title: Text(
                    song.path.split('/').last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _playSong(song.path),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
