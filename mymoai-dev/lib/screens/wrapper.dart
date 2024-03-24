
import 'package:flutter/material.dart';
import 'package:mymoai/screens/authenticate/authenticate.dart';
import 'package:mymoai/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:mymoai/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
