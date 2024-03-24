import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymoai/models/moai.dart';
import 'package:mymoai/models/user.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeMoai {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Moai? _userFromFirebaseUser(User? moai) {
    return moai != null ? Moai(uid: moai.uid) : null;
  }

  Stream<Moai?> get moai {
    return _auth.authStateChanges().map((User? moai) => _userFromFirebaseUser(moai));
  }

  Future makeMoai(String name, String description, int memberMax, int premium, String approval,
      int minSalary, AcctDetails currAcctDeets, Users currUser) async {
    try{
      DocumentReference moaiRef = await FirebaseFirestore.instance.collection('moais').add({
        'name': name,
        'description': description,
        'memberMax': memberMax,
        'premium': premium,
        'approval': approval,
        'minSalary': minSalary,
        'age': 2024-currAcctDeets.year,
        'city': currAcctDeets.city,
        'occupation': currAcctDeets.occupation,
        'education': currAcctDeets.education,
        'salary': currAcctDeets.salary,
        'dependents': currAcctDeets.dependents,
        'creditScore': currAcctDeets.creditScore,
        'members': [currUser.uid],
      });
      print(moaiRef.id);  // Returns the id of the newly created Moai
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


}