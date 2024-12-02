import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MiniPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final String songTitle;
  final String songImage;

  const MiniPlayer({
    super.key,
    required this.audioPlayer,
    required this.songTitle,
    required this.songImage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: audioPlayer.playingStream,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;
        return isPlaying
            ? Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          songImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      songTitle,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      ),
                      color: Colors.white,
                      onPressed: () => audioPlayer.play(),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}