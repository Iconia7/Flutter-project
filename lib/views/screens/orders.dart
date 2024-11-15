import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/views/screens/songplayer.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      _loadSongs();
    }
  }

  Future<void> _loadSongs() async {
    List<SongModel> songs = await _audioQuery.querySongs();
    setState(() {
      _songs = songs;
    });
  }

  void _openSongPlayer(SongModel song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPlayerScreen(
          song: {
            'title': song.title ?? 'Unknown Title',  // Ensure title is non-null
            'artist': song.artist ?? 'Unknown Artist',  // Ensure artist is non-null
            'filePath': song.data ?? '',  // Ensure filePath is non-null
            'image': song.albumId != null ? song.albumId.toString() : '',  // Ensure image is non-null
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: _songs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                return ListTile(
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    artworkFit: BoxFit.cover,
                    artworkBorder: BorderRadius.circular(8),
                    nullArtworkWidget: Icon(
                      Icons.music_note,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                  title: Text(
                    song.title ?? 'Unknown Title',  // Ensure title is non-null
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    song.artist ?? 'Unknown Artist',  // Ensure artist is non-null
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _openSongPlayer(song),
                );
              },
            ),
    );
  }
}
