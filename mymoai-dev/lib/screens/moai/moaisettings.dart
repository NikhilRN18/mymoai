import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoaiSettings extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<MoaiSettings> {

  final Map<String, String> settings = {"Access":"Invite-Only","Premium":"25","Max Members":"50"};

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
            'Moai Settings',
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: TextField(
                      controller: TextEditingController(text: settings.keys.toList()[index]+": " + settings.values.toList()[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
