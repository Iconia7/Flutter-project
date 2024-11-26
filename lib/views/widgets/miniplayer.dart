import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project/views/widgets/recent.dart';

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          // Song Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              songImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          // Song Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  songTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                StreamBuilder<Duration>(
                  stream: audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return Text(
                      "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  },
                ),
              ],
            ),
          ),
          // Play/Pause Button
          IconButton(
            icon: StreamBuilder<bool>(
              stream: audioPlayer.playingStream,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data ?? false;
                return Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.blue,
                );
              },
            ),
            onPressed: () {
              if (audioPlayer.playing) {
                audioPlayer.pause();
              } else {
                audioPlayer.play();
                // Add the song to Recently Played
                RecentlyPlayedManager().addSong(songTitle, songImage);
              }
            },
          ),
        ],
      ),
    );
  }
}
