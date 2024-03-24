import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransHist extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<TransHist> {
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
            'Transaction History',
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
                  color: Color(0xFFCA7B80), // This sets the background color of the card to #CA7B80
                  child: ListTile(
                    title: Text('Transaction ${index + 1}', style: TextStyle(fontSize: 24, color: Colors.white)), // This sets the font size of the text to 24 and the color to white
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Amount:', style: TextStyle(color: Colors.white)), // This is a placeholder for the transaction amount
                        Text('Date:', style: TextStyle(color: Colors.white)), // This is a placeholder for the transaction date
                        Text('Other Details:', style: TextStyle(color: Colors.white)), // This is a placeholder for other transaction details
                      ],
                    ),
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
