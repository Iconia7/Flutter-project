
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecentlyPlayedManager {
  static final RecentlyPlayedManager _instance =
      RecentlyPlayedManager._internal();

  final List<Map<String, String>> _recentlyPlayed = [];

  factory RecentlyPlayedManager() {
    return _instance;
  }

  RecentlyPlayedManager._internal();

  // Getter for recently played songs
  List<Map<String, String>> get recentlyPlayed =>
      List.unmodifiable(_recentlyPlayed);

  // Add a song to the recently played list
  void addSong(String title, String image) {
    _recentlyPlayed.removeWhere((song) => song['title'] == title);
    _recentlyPlayed.insert(0, {'title': title, 'image': image});

    if (_recentlyPlayed.length > 10) {
      _recentlyPlayed.removeLast();
    }

    saveRecentlyPlayed(); // Save updated list to storage
  }

  // Save recently played songs to SharedPreferences
  void saveRecentlyPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_recentlyPlayed);
    await prefs.setString('recently_played', jsonString);
  }

  // Load recently played songs from SharedPreferences
  Future<void> loadRecentlyPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('recently_played');
    if (jsonString != null) {
      _recentlyPlayed
        ..clear()
        ..addAll(List<Map<String, String>>.from(jsonDecode(jsonString)));
    }
  }
}
