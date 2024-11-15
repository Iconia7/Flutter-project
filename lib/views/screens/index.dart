import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatelessWidget {
  final List<String> carouselImages = [
    'assets/Album 1.jpeg',
    'assets/Jitu.jpeg',
    'assets/Nyashinski.jpeg',
  ];

  final List<Map<String, String>> recentlyPlayed = [
    {'title': 'Song 1', 'image': 'assets/images/Song 1.jpeg'},
    {'title': 'Song 2', 'image': 'assets/images/Song 2.jpeg'},
    {'title': 'Song 3', 'image': 'assets/images/Song 3.jpeg'},
    {'title': 'Song 3', 'image': 'assets/images/Nyashinski.jpeg'},
  ];

  final List<Map<String, String>> playlists = [
    {'name': 'Chill Vibes', 'image': 'assets/images/Album 1.jpeg'},
    {'name': 'Workout Hits', 'image': 'assets/images/Song 1.jpeg'},
    {'name': 'Top 50', 'image': 'assets/images/Song 2.jpeg'},
  ];

   DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              // Song Carousel
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                ),
                items: carouselImages.map((image) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/song_player', arguments: image);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              // Recently Played Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recently Played",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentlyPlayed.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/song_player',
                                arguments: recentlyPlayed[index],
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 100,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      recentlyPlayed[index]['image']!,
                                      fit: BoxFit.cover,
                                      height: 80,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    recentlyPlayed[index]['title']!,
                                    style: TextStyle(
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Playlists Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Playlists",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/playlist', arguments: playlists[index]);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  playlists[index]['image']!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              title: Text(
                                playlists[index]['name']!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
