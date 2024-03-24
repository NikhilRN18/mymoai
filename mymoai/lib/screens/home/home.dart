import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymoai/services/auth.dart';
import 'package:mymoai/services/database_user.dart';
import 'package:provider/provider.dart';
import 'package:mymoai/screens/home/account_list.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:mymoai/screens/home/settings_form.dart';
import 'package:mymoai/screens/moai/create_moai.dart';
import 'package:mymoai/screens/search/search.dart';

class Home extends StatelessWidget {

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


    return StreamProvider<List<AcctDetails>?>.value(
      value: DatabaseUser().acctDeets,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MyMoai',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFFFFD1DC), fontSize: 32,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle, size: 50),  // adjust size as needed
              onPressed: () {
                // Add your action here
              },
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 412,
              maxHeight: 915,
            ),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Placeholder Information $index'),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFff7f50),
          backgroundColor: Color(0xFFFFD1DC),
          unselectedItemColor: Color(0xFFC2185B),
          currentIndex: 2, // This highlights the third item, which is "Build Moai"
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Search()));
            }
            if (value == 2) { // Dashboard

            }
            if (value == 3) { // Create Moai
              AcctDetails acctDeets = await _getAcctDeets();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoaiForm(acctDeets: acctDeets)));
            }
            if (value == 4) { // Log Out
              _signOut();
            }
          },
        ),

      ),
    );
  }
}
