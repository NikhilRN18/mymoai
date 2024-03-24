import 'package:mymoai/models/user.dart';

class Moai {
  final String uid;

  Moai({ required this.uid });
}

class MoaiData {

  final String? uid;
  String name;
  String description;
  int memberMax;
  int premium;
  String approval;
  int minSalary;
  int age;
  String city;
  String occupation;
  String education;
  int avgSalary;
  int avgDependents;
  int avgCreditScore;
  List<Users> members;

  MoaiData( { this.uid, required this.name,required this.description,required this.memberMax,required this.premium,
    required this.approval, required this.minSalary, required this.age, required this.city,required this.occupation,
    required this.education,required this.avgSalary, required this.avgDependents,required this.avgCreditScore,
    required this.members} );

}