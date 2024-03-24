import "package:cloud_firestore/cloud_firestore.dart";
import 'package:mymoai/models/acctdetails.dart';
import 'package:mymoai/models/user.dart';

class DatabaseUser {

  final String? uid;
  DatabaseUser( {this.uid} );

  final CollectionReference accountCollection = FirebaseFirestore.instance.collection('acctDeets');

  Future updateUserData(String firstName, String lastName, int month, int day, int year, String email,
      int phoneNumber, String city, String state, String country, String occupation, String education, int salary,
      int dependents, int creditScore) async {
    return await accountCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'month': month,
      'day': day,
      'year': year,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': country == 'USA' ? state : '',
      'country': country,
      'occupation': occupation,
      'education': education,
      'salary': salary,
      'dependents': dependents,
      'creditScore': creditScore,
    });
  }

  List<AcctDetails> _acctListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return AcctDetails(
        firstName: doc.get('firstName') ?? '',
        lastName: doc.get('lastName') ?? '',
        month: doc.get('month') ?? 0,
        day: doc.get('day') ?? 0,
        year: doc.get('year') ?? 0,
        email: doc.get('email') ?? '',
        phoneNumber: doc.get('phoneNumber') ?? 0,
        city: doc.get('city') ?? '',
        state: doc.get('state') ?? '',
        country: doc.get('country') ?? '',
        occupation: doc.get('occupation') ?? '',
        education: doc.get('education') ?? '',
        salary: doc.get('salary') ?? 0,
        dependents: doc.get('dependents') ?? 0,
        creditScore: doc.get('creditScore') ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid ?? '', firstName: snapshot.get("firstName"),
        lastName: snapshot.get("lastName"),
        month: snapshot.get("month"),
        day: snapshot.get("day"),
        year: snapshot.get("year"),
        email: snapshot.get("email"),
        phoneNumber: snapshot.get("phoneNumber"),
        city: snapshot.get("city"),
        state: snapshot.get("state"),
        country: snapshot.get("country"),
        occupation: snapshot.get("occupation"),
        education: snapshot.get("education"),
        salary: snapshot.get("salary"),
        dependents: snapshot.get("dependents"),
        creditScore: snapshot.get("creditScore"));
  }

  Stream<List<AcctDetails>> get acctDeets {
    return accountCollection.snapshots()
        .map(_acctListFromSnapshot);
  }

  Stream<UserData> get userData {
    return accountCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Future<AcctDetails> getAccountDetails(String uid) async {
    DocumentSnapshot docSnapshot = await accountCollection.doc(uid).get();
    return AcctDetails(
      firstName: docSnapshot.get('firstName') ?? '',
      lastName: docSnapshot.get('lastName') ?? '',
      month: docSnapshot.get('month') ?? 0,
      day: docSnapshot.get('day') ?? 0,
      year: docSnapshot.get('year') ?? 0,
      email: docSnapshot.get('email') ?? '',
      phoneNumber: docSnapshot.get('phoneNumber') ?? 0,
      city: docSnapshot.get('city') ?? '',
      state: docSnapshot.get('state') ?? '',
      country: docSnapshot.get('country') ?? '',
      occupation: docSnapshot.get('occupation') ?? '',
      education: docSnapshot.get('education') ?? '',
      salary: docSnapshot.get('salary') ?? 0,
      dependents: docSnapshot.get('dependents') ?? 0,
      creditScore: docSnapshot.get('creditScore') ?? 0,
    );
  }
  Future<String> getName(String uid) async {
    DocumentSnapshot docSnapshot = await accountCollection.doc(uid).get();
    return docSnapshot.get('firstName') + docSnapshot.get('lastName');
  }
}