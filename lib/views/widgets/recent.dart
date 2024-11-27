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
  Future<void> addSong(String title, String image) async {
    _recentlyPlayed.removeWhere((song) => song['title'] == title);
    _recentlyPlayed.insert(0, {'title': title, 'image': image});

    if (_recentlyPlayed.length > 10) {
      _recentlyPlayed.removeLast();
    }

    await saveRecentlyPlayed();
  }

  // Save recently played songs to SharedPreferences
  Future<void> saveRecentlyPlayed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(_recentlyPlayed);
      await prefs.setString('recently_played', jsonString);
    } catch (e) {
      print('Error saving recently played songs: $e');
    }
  }

  // Load recently played songs from SharedPreferences
  Future<void> loadRecentlyPlayed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('recently_played');
      if (jsonString != null) {
        _recentlyPlayed
          ..clear()
          ..addAll(List<Map<String, String>>.from(jsonDecode(jsonString)));
      }
    } catch (e) {
      print('Error loading recently played songs: $e');
    }
  }
}
