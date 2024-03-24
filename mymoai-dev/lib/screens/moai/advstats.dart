import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdvStats extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<AdvStats> {

  final Map<String, String> stats = {'Age':'30','Salary':'1000000','City':'Charlottesville','State':'VA',
    'Credit Score':'830'};

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
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Most Common " + stats.keys.toList()[index] + ": " + stats.values.toList()[index]),
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
