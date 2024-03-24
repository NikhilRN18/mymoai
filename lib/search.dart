import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Find your Moai...',
          ),
          onChanged: (value) {
            setState(() {
              _isSearching = value.isNotEmpty;
            });
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 412,
            maxHeight: 915,
          ),
          child: _isSearching ? _buildSearchResults() : _buildRecommendedOptions(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFff7f50), 
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.database),
            label: 'MyMoais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Build Moai',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedOptions() {
    // Replace this with your actual recommended options
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Recommended Option ${index + 1}'),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    // Replace this with your actual search logic
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Search Result ${index + 1}'),
        );
      },
    );
  }
}
