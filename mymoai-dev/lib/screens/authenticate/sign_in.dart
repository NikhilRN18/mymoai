import 'package:flutter/material.dart';
import 'package:mymoai/services/auth.dart';
import 'package:mymoai/shared/loading.dart';
import 'package:flutter/gestures.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  SignIn({ this.toggleView });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        widget.toggleView!();
      };

    return loading ? Loading() : Scaffold(
      body: Center(
        child: Container(
          width: 320,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/MyMoaiNameLogo.png'),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (val) => val!.isEmpty ? "Enter an Email" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (val) => val!.length < 6 ? "Enter a Password (6+ chars)" : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
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
                  color: Color(0xFFC2185B),
                  textColor: Colors.white,
                  child: Text('Sign In'),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInEmail(email, password);
                      print(result.uid);
                      if(result == null) {
                        setState(() {
                          error = 'Incorrect Username or Password';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                DefaultTextStyle(
                  style: TextStyle(fontSize: 14, color: Colors.pink),
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
                SizedBox(height: 12.0),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
