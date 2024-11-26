import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/views/screens/songplayer.dart';
import 'package:project/views/widgets/recent.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, String>> carouselImages = [
    {
      'image': 'assets/images/Album 1.jpeg',
      'filePath': 'assets/audio/busy.mp3',
      'title': 'Album 1 Song',
    },
    {
      'image': 'assets/images/Jitu.jpeg',
      'filePath': 'assets/audio/jitu.mp3',
      'title': 'Jitu Song',
    },
    {
      'image': 'assets/images/Nyashinski.jpeg',
      'filePath': 'assets/audio/perfect.mp3',
      'title': 'Nyashinski Song',
    },
    {
      'image': 'assets/images/kifo.jpg',
      'filePath': 'assets/audio/kifo.mp3',
      'title': 'Iyani Song',
    },
  ];

  final List<List<Map<String, String>>> playlists = [
    [
      {
        'title': 'Workout Hit 1',
        'image': 'assets/images/Album 1.jpeg',
        'filePath': 'assets/audio/busy.mp3',
      },
      {
        'title': 'Workout Hit 2',
        'image': 'assets/images/see.jpeg',
        'filePath': 'assets/audio/see you.mp3',
      },
    ],
    [
      {
        'title': 'Chill Vibe 1',
        'image': 'assets/images/dilemma.jpeg',
        'filePath': 'assets/audio/dilemma.mp3',
      },
      {
        'title': 'Chill Vibe 2',
        'image': 'assets/images/have.jpeg',
        'filePath': 'assets/audio/all i have.mp3',
      },
    ],
  ];

  final List<Map<String, String>> trendingSongs = [
    {
      'title': 'Kifo Cha Mende',
      'image': 'assets/images/kifo.jpg',
      'filePath': 'assets/audio/kifo.mp3',
    },
    {
      'title': 'Kudade',
      'image': 'assets/images/kudade.jpeg',
      'filePath': 'assets/audio/kudade.mp3',
    },
    {
      'title': 'Anguka Nayo',
      'image': 'assets/images/anguka.jpeg',
      'filePath': 'assets/audio/anguka nayo.mp3',
    },
    {
      'title': 'Like you',
      'image': 'assets/images/like.jpeg',
      'filePath': 'assets/audio/like you.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                ),
                items: carouselImages.map((song) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayerScreen(
                            song: song,
                            playlist: carouselImages,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            song['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            song['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Recently Played Section
              _buildSectionTitle(context, "Recently Played"),
              _buildDynamicRecentlyPlayed(context),
              const SizedBox(height: 20),
              // Playlists Section
              _buildSectionTitle(context, "Playlists"),
              _buildHorizontalList(playlists, context),
              const SizedBox(height: 20),
              // Trending Songs Section
              _buildSectionTitle(context, "Trending Songs"),
              _buildVerticalList(trendingSongs, context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Dynamically built Recently Played list
  Widget _buildDynamicRecentlyPlayed(BuildContext context) {
    final recentlyPlayed = RecentlyPlayedManager().recentlyPlayed;

    if (recentlyPlayed.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "No songs played yet.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentlyPlayed.length,
        itemBuilder: (context, index) {
          final song = recentlyPlayed[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(
                    song: song,
                    playlist: recentlyPlayed,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      song['image']!,
                      fit: BoxFit.cover,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    song['title']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalList(
      List<List<Map<String, String>>> list, BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final playlist = list[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(
                    song: playlist[0],
                    playlist: playlist,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 120,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      playlist[0]['image']!,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Playlist ${index + 1}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList(
      List<Map<String, String>> list, BuildContext context) {
    return Column(
      children: list.map((song) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongPlayerScreen(
                  song: song,
                  playlist: list,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  song['image']!,
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
              ),
              title: Text(
                song['title']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
