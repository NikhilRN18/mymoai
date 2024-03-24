import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintText: "Email",
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ), focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0)
  ),
);

// navigationBar = BottomNavigationBar(
//   selectedItemColor: Color(0xFFff7f50),
//   backgroundColor: Color(0xFFFFD1DC),
//   unselectedItemColor: Color(0xFFC2185B),
//   currentIndex: 2, // This highlights the third item, which is "Build Moai"
//   items: const <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(FontAwesomeIcons.database),
//       label: 'My Moais',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.search),
//       label: 'Search',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.dashboard),
//       label: 'Dashboard',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.add),
//       label: 'Create Moai',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.exit_to_app),
//       label: 'Log Out',
//     ),
//   ],
//   onTap: (value) async {
//     if (value == 0) { // My Moais
//
//     }
//     if (value == 1) { // Search
//
//     }
//     if (value == 2) { // Dashboard
//
//     }
//     if (value == 3) { // Create Moai
//       AcctDetails acctDeets = await _getAcctDeets();
//       Navigator.push(context,
//         MaterialPageRoute(builder: (context) => MoaiForm(acctDeets: acctDeets)));
//     }
//     if (value == 4) { // Log Out
//   _signOut();
//   }
//   },
// );