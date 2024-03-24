import 'package:flutter/material.dart';
import 'signin.dart';
import 'signup.dart';
import 'dashboard.dart';
import 'userinfo.dart';
import 'createmoai.dart';
import 'search.dart';
import 'moaiinfo.dart';
import 'advstats.dart';
import 'memberlist.dart';
import 'transhist.dart';
import 'moaisettings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  theme: ThemeData(
    primaryColor: Color(0xFFff7f50), // This sets the default color to #ff7f50
    colorScheme: ThemeData().colorScheme.copyWith(secondary: Color(0xFFD1DC)), // This sets the secondary color to orange
  ),
      // home: SignIn(),
      // home: SignUp(),
      // home: Dashboard()
      // home: UserInfo()
      // home: CreateMoai()
      // home: Search()
      // home: MoaiInfo()
      // home: AdvStats()
      // home: MemberList()
      home: TransHist()
      // home: MoaiSettings()
    );
  }
}
