import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<File> _musicFiles = [];
  bool isPlaying = false;
  File? currentFile;

  // Function to pick files from device storage
  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        setState(() {
          _musicFiles = files;
        });
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  // Function to play selected file
  Future<void> _playFile(File file) async {
    await _audioPlayer.stop(); // Stop any currently playing audio
    await _audioPlayer.setSourceUrl(file.path); // Set the file to be played
    await _audioPlayer.resume(); // Start playback
    setState(() {
      isPlaying = true;
      currentFile = file;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Library",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_music),
            onPressed: _pickFiles,
          ),
        ],
      ),
      body: _musicFiles.isEmpty
          ? const Center(
              child: Text(
                "No music files found. Tap the icon to add music.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _musicFiles.length,
              itemBuilder: (context, index) {
                File file = _musicFiles[index];
                return ListTile(
                  title: Text(file.path.split('/').last),
                  leading: const Icon(Icons.music_note),
                  trailing: Icon(
                    file == currentFile && isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onTap: () => _playFile(file),
                );
              },
            ),
    );
  }
}
