import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/views/screens/songplayer.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel for featured songs
          const SizedBox(
            height: 350,
            child: SongCarousel(),
          ),
          const SizedBox(height: 20),
          const Text(
            "Recently Played",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                albumCover('assets/images/Song 1.jpeg', 'Song 1'),
                albumCover('assets/images/Song 2.jpeg', 'Song 2'),
                albumCover('assets/images/Song 3.jpeg', 'Song 3'),
                albumCover('assets/images/Song 1.jpeg', 'Song 4'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Popular Albums",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                albumCover('assets/images/Song 1.jpeg', 'Album 1'),
                albumCover('assets/images/Song 2.jpeg', 'Album 2'),
                albumCover('assets/images/Song 3.jpeg', 'Album 3'),
                albumCover('assets/images/Song 2.jpeg', 'Album 4'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Your Playlists",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          playlistTile("Chill Vibes", "30 songs"),
          playlistTile("Workout Mix", "25 songs"),
          playlistTile("Top Hits 2023", "40 songs"),
        ],
      ),
    );
  }

  // Widget for a sample album cover
  Widget albumCover(String imagePath, String label) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }

  // Widget for a sample playlist
  Widget playlistTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.music_note, color: Colors.black54),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.play_arrow),
    );
  }
}

// Carousel Widget for scrolling song images
class SongCarousel extends StatefulWidget {
  const SongCarousel({super.key});

  @override
  _SongCarouselState createState() => _SongCarouselState();
}

class _SongCarouselState extends State<SongCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      children: [
        songCover(context, 'assets/images/Song 1.jpeg', 'Song 1'),
        songCover(context, 'assets/images/Song 2.jpeg', 'Song 2'),
        songCover(context, 'assets/images/Song 3.jpeg', 'Song 3'),
      ],
    );
  }

  // Widget for each song cover in the carousel with onTap functionality
  Widget songCover(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongPlayer(imagePath: imagePath, songTitle: label),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

