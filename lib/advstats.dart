import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdvStats extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<AdvStats> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 50),
            onPressed: () {
              Navigator.pop(context); // This goes back to the previous page
            },
          ),
          title: Text(
            'Advanced Statistics',
            style: TextStyle(
              color: Color(0xFFFFD1DC), // This sets the color of the text to pink
              fontSize: 32,
            ),
          ),
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
                    title: Text('Data Information ${index + 1}'),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFff7f50), 
          currentIndex: 0, // This highlights the first item, which is "MyMoais"
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
