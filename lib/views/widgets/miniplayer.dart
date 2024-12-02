import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/musiccontroller.dart';

class MiniPlayer extends StatelessWidget {
  final MusicController musicController = Get.find();

  MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (musicController.currentSongTitle.value.isEmpty) {
        return SizedBox.shrink(); 
      }

      return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              musicController.currentSongImage.value,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.music_note, size: 50, color: Colors.white);
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                musicController.currentSongTitle.value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            IconButton(
              icon: Icon(
                musicController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: musicController.togglePlayPause,
            ),
          ],
        ),
      );
    });
  }
}
