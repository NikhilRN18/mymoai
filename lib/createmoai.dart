import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateMoai extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<CreateMoai> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // title: Image.asset('assets/images/MyMoaiLogo.png'),
          centerTitle: true,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 412,
              maxHeight: 915,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100.0, // Set your desired width in pixels
                    height: 100.0, // Set your desired height in pixels
                    child: Image.asset('assets/images/MyMoaiLogo.png'),
                  ),
                  Text(
                    'Create A Moai',
                    style: TextStyle(fontSize: 24),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('User Data ${index + 1}'),
                            subtitle: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your data',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    color: Color(0xFFFFFD1DC),
                    child: Text('Submit Moai'),
                    onPressed: () {
                      // Put your save changes logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFff7f50), 
          currentIndex: 2, // This highlights the third item, which is "Build Moai"
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
