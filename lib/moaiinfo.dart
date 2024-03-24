import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoaiInfo extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<MoaiInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Temp Moai Information',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFFFFD1DC), fontSize: 32,
              ),
            ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle, size: 50),
              onPressed: () {
                // Put your logic here
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
                        'Brief Summary',
                        style: TextStyle(fontSize: 14, color: Color(0xFFd2b48c)), // This sets the color and font size of the text
                      ),
                      Expanded(
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
                            // Put your logic here
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
                            // Put your logic here
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
                            // Put your logic here
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
                            // Put your logic here
                          },
                          child: Text('Settings', style: TextStyle(color: Colors.white)), // This sets the name and color of the button
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
          currentIndex: 0, // This highlights the third item, which is "Build Moai"
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
      ),
    );
  }
}
