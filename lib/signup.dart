import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUp extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      //launch('https://your-sign-up-url.com');
    };

  late AnimationController _controller;
  List<Color> _colors = [Colors.blue, Colors.red];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _colors = _colors.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _colors,
          ),
        ),
        child: Center(
          child: Container(
            width: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'welcome to...',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFFFD1DC),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                Image.asset('assets/images/MyMoaiNameLogo.png'),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFFCA7B80),
                      value: true,
                      onChanged: (bool? value) {},
                    ),
                    Text('Remember me'),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Color(0xFFFFD1DC),
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 20),
                DefaultTextStyle(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: _tapGestureRecognizer,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
