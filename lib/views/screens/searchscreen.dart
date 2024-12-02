import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];
  bool _isLoading = false; // To show a loading indicator

  Future<void> _search(String query) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final url = Uri.parse('https://mzukakibao.com/?s=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final searchResults = <Map<String, String>>[];

        // Adjusted parsing logic
        document.querySelectorAll('.td_module_wrap').forEach((element) {
          final titleElement =
              element.querySelector('.entry-title a'); // Updated selector
          final title = titleElement?.text.trim() ?? '';
          final link = titleElement?.attributes['href'] ?? '';

          if (title.isNotEmpty && link.isNotEmpty) {
            searchResults.add({
              'title': title,
              'url': link,
            });
          }
        });

        setState(() {
          _searchResults = searchResults;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      debugPrint('Error during search: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mzukakibao Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a song',
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        _search(query);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _search(query);
                    }
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final song = _searchResults[index];
                return ListTile(
                  title: Text(song['title'] ?? 'Unknown'),
                  onTap: () {
                    // Handle item tap, like opening a new screen or webview
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
