import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignIn extends StatefulWidget {
  @override
  _MyUIState createState() => _MyUIState();
}

class _MyUIState extends State<SignIn> with SingleTickerProviderStateMixin {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      //launch('https://your-sign-up-url.com');
    };

  late AnimationController _controller;
  // List<Color> _colors = [Color.fromARGB(255, 255, 127, 80), Color.fromARGB(255, 202, 123, 128)];
  List<Color> _colors = [Colors.grey, Colors.pink];

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
                  child: Text('Sign In'),
                ),
                SizedBox(height: 20),
                DefaultTextStyle(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
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

// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// //import 'package:url_launcher/url_launcher.dart';

// class SignIn extends StatefulWidget {
//   @override
//   _MyUIState createState() => _MyUIState();
// }

// class _MyUIState extends State<SignIn> {
//   final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
//     ..onTap = () {
//       //launch('https://your-sign-up-url.com');
//     };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: 320,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset('assets/images/MyMoaiNameLogo.png'),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Username',
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Password',
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: <Widget>[
//                   Checkbox(
//                     checkColor: Colors.white,
//                     activeColor: Color(0xFFCA7B80),
//                     value: true,
//                     onChanged: (bool? value) {},
//                   ),
//                   Text('Remember me'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               MaterialButton(
//                 minWidth: double.infinity,
//                 color: Color(0xFFFFD1DC),
//                 textColor: Colors.white,
//                 onPressed: () {},
//                 child: Text('Sign In'),
//               ),
//               SizedBox(height: 20),
//               DefaultTextStyle(
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Don't have an account? ",
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: 'Sign Up',
//                         style: TextStyle(
//                           decoration: TextDecoration.underline,
//                         ),
//                         recognizer: _tapGestureRecognizer,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
