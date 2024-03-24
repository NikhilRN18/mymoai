import "package:cloud_firestore/cloud_firestore.dart";
import 'package:mymoai/models/moaidetails.dart';
import 'package:mymoai/models/moai.dart';
import 'package:mymoai/models/user.dart';

class DatabaseMoai {

  final String? uid;
  DatabaseMoai( {this.uid} );

  final CollectionReference moaiCollection = FirebaseFirestore.instance.collection('moais');

  Future updateMoaiData(  String name,
  String description,
  int memberMax,
  int premium,
  String approval,
  int minSalary,
  int age,
  String city,
  String occupation,
  String education,
  int avgSalary,
  int avgDependents,
  int avgCreditScore,
  List<String> members) async {
    return await moaiCollection.doc(uid).set({
      'name': name,
      'description': description,
      'memberMax': memberMax,
      'premium': premium,
      'approval': approval,
      'minSalary': minSalary,
      'age': age,
      'city': city,
      'occupation': occupation,
      'education': education,
      'avgSalary': avgSalary,
      'avgDependents': avgDependents,
      'avgCreditScore': avgCreditScore,
      'members': members
    });
  }

  List<MoaiDetails> _moaiListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return MoaiDetails(
        name: doc.get('name') ?? '',
        description: doc.get('description') ?? '',
        memberMax: doc.get('memberMax') ?? 0,
        premium: doc.get('premium') ?? 0,
        approval: doc.get('approval') ?? '',
        minSalary: doc.get('minSalary') ?? 0,
        age: doc.get('age') ?? 0,
        city: doc.get('city') ?? '',
        occupation: doc.get('occupation') ?? '',
        education: doc.get('education') ?? '',
        avgSalary: doc.get('avgSalary') ?? 0,
        avgDependents: doc.get('avgDependents') ?? 0,
        avgCreditScore: doc.get('avgCreditScore') ?? 0,
        members: doc.get('members') ?? []
      );
    }).toList();
  }

  MoaiData _moaiDataFromSnapshot(DocumentSnapshot snapshot) {
    return MoaiData(uid: uid ?? '', name: snapshot.get('name'),
      description: snapshot.get('description'),
      memberMax: snapshot.get('memberMax'),
      premium: snapshot.get('premium'),
      approval: snapshot.get('approval'),
      minSalary: snapshot.get('minSalary'),
      age: snapshot.get('age'),
      city: snapshot.get('city'),
      occupation: snapshot.get('occupation'),
      education: snapshot.get('education'),
      avgSalary: snapshot.get('avgSalary'),
      avgDependents: snapshot.get('avgDependents'),
      avgCreditScore: snapshot.get('avgCreditScore'),
      members: snapshot.get('members'));
  }

  Stream<List<MoaiDetails>> get moaiDeets {
    return moaiCollection.snapshots()
        .map(_moaiListFromSnapshot);
  }

  Stream<MoaiData> get moaiData {
    return moaiCollection.doc(uid).snapshots()
        .map(_moaiDataFromSnapshot);
  }
}