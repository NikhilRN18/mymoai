import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymoai/screens/home/settings_form.dart';
import 'package:mymoai/screens/moai/advstats.dart';
import 'package:mymoai/screens/moai/memberlist.dart';
import 'package:mymoai/screens/moai/moaisettings.dart';
import 'package:mymoai/screens/moai/transhist.dart';
import 'package:mymoai/services/database_user.dart';

import '../../models/acctdetails.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import '../search/search.dart';
import 'create_moai.dart';

class MoaiInfo extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<MoaiInfo> {

  final List<String> names = ['Om Gole','Rishabh Chhabra','Nikhil Nair','Joe Biden','Hooey Hacker','Sid Tickle','Batman','Evil Om Gole','Mr. Bean','Thomas Jefferson'];
  bool loading = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      await _auth.signOut();
    }

    Future<AcctDetails> _getAcctDeets() async {
      String uid = await _auth.currentUser();
      return await DatabaseUser().getAccountDetails(uid);
    }

    return loading ? Loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Beach Week 2024',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFFFFD1DC), fontSize: 32,
              ),
            ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle, size: 50),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsForm()));
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
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Dashboard',
                        style: TextStyle(fontSize: 14, color: Color(0xFFd2b48c)), // This sets the color and font size of the text
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(names[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD1DC), // This sets the background color of the button
                          borderRadius: BorderRadius.circular(10.0), // This makes the button curved at the corners
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AdvStats()));
                          },
                          child: Text('Adv Stats', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD1DC), // This sets the background color of the button
                          borderRadius: BorderRadius.circular(10.0), // This makes the button curved at the corners
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MemberList()));
                          },
                          child: Text('Member List', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD1DC), // This sets the background color of the button
                          borderRadius: BorderRadius.circular(10.0), // This makes the button curved at the corners
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => TransHist()));
                          },
                          child: Text('Trans. Hist.', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFD1DC), // This sets the background color of the button
                          borderRadius: BorderRadius.circular(10.0), // This makes the button curved at the corners
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MoaiSettings()));
                          },
                          child: Text('Settings', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent, // This sets the background color of the button
                          borderRadius: BorderRadius.circular(10.0), // This makes the button curved at the corners
                        ),
                        child: MaterialButton(
                          onPressed: () {

                          },
                          child: Text('APPLY FOR CLAIM', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
              loading = false;
            }
            if (value == 1) { // Search
              loading = true;
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Search()));
            }
            if (value == 2) { // Dashboard
              loading = true;
              Navigator.pop(context);
            }
            if (value == 3) { // Create Moai
              loading = true;
              Navigator.pop(context);
              AcctDetails acctDeets = await _getAcctDeets();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoaiForm(acctDeets: acctDeets)));
            }
            if (value == 4) { // Log Out
              loading = true;
              _signOut();
            }
          },
        ),
      ),
    );
  }
}
