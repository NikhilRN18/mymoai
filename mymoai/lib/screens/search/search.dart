import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymoai/services/auth.dart';
import 'package:mymoai/services/database_user.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:mymoai/screens/home/settings_form.dart';
import 'package:mymoai/screens/moai/create_moai.dart';

class Search extends StatefulWidget {

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    void _signOut() async {
      await _auth.signOut();
    }

    Future<AcctDetails> _getAcctDeets() async {
      String uid = await _auth.currentUser();
      return await DatabaseUser().getAccountDetails(uid);
    }

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
        backgroundColor: Color(0xFFFFD1DC),
        unselectedItemColor: Color(0xFFC2185B),
        currentIndex: 1, // This highlights the third item, which is "Build Moai"
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.database),
            label: 'My Moais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Moai',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Log Out',
          ),
        ],
        onTap: (value) async {
          if (value == 0) { // My Moais

          }
          if (value == 1) { // Search

          }
          if (value == 2) { // Dashboard
            Navigator.pop(context);
          }
          if (value == 3) { // Create Moai
            AcctDetails acctDeets = await _getAcctDeets();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MoaiForm(acctDeets: acctDeets)));
          }
          if (value == 4) { // Log Out
            Navigator.pop(context);
            _signOut();
          }
        },
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
