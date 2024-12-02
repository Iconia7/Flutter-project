import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlyPlayedManager {
  static final RecentlyPlayedManager _instance =
      RecentlyPlayedManager._internal();

  final List<Map<String, String>> _recentlyPlayed = [];

  factory RecentlyPlayedManager() {
    return _instance;
  }

  RecentlyPlayedManager._internal() {
    loadRecentlyPlayed();
  }

  List<Map<String, String>> get recentlyPlayed =>
      List.unmodifiable(_recentlyPlayed);

void addSong(Map<String, String> song) {
  _recentlyPlayed.removeWhere((s) => s['title'] == song['title']);
  _recentlyPlayed.insert(0, {'title': song['title']!, 'image': song['image']!});

    if (_recentlyPlayed.length > 10) {
      _recentlyPlayed.removeLast();
    }

    saveRecentlyPlayed();
  }

  Future<void> saveRecentlyPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_recentlyPlayed);
    await prefs.setString('recently_played', jsonString);
  }

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
