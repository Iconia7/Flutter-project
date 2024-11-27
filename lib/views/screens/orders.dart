import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:project/views/screens/songplayer.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required to access songs.'),
        ),
      );
    }
  }

  /// Loads MP3 songs from specified directories.
  Future<void> _loadSongs() async {
    try {
      final directory = await getExternalStorageDirectory();

      if (directory == null) {
        debugPrint('No external storage directory found.');
        return;
      }

      final musicPaths = [
        "${directory.path}/music",
        "/storage/emulated/0/music",
        "/sdcard/Music",
      ];

      List<FileSystemEntity> files = [];

      for (String path in musicPaths) {
        final musicDir = Directory(path);
        if (musicDir.existsSync()) {
          files.addAll(musicDir
              .listSync()
              .where((file) => file.path.toLowerCase().endsWith('.mp3')));
        }
      }

      setState(() {
        _songs = files;
      });

      if (_songs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No MP3 files found in the Music directories.'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading songs: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load songs. Please try again.'),
        ),
      );
    }
  }

  /// Generates a playlist for the song player.
  List<Map<String, String>> _generatePlaylist() {
    return _songs.map((song) {
      return {
        'title': song.path.split('/').last,
        'filePath': song.path,
        'image': 'assets/images/default_image.jpg',
      };
    }).toList();
  }

  /// Refreshes the song list.
  Future<void> _refreshSongs() async {
    await _loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshSongs,
              child: ListView.builder(
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
                    onTap: () {
                      final playlist = _generatePlaylist();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayerScreen(
                            song: playlist[index],
                            playlist: playlist,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
