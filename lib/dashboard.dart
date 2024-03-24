import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/MyMoaiNameLogo.png',
              width: 200,  // Adjust the width as needed
              height: 200,  // Adjust the height as needed
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
        );
      },
    );
  }
}
