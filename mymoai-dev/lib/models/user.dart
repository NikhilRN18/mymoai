class Users {
  final String uid;

  Users({ required this.uid });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }
}

class UserData {

  final String? uid;
  final String firstName;
  final String lastName;
  final int month;
  final int day;
  final int year;
  final String email;
  final int phoneNumber;
  final String city;
  final String state;
  final String country;
  final String occupation;
  final String education;
  final int salary;
  final int dependents;
  final int creditScore;

  UserData( { this.uid, required this.firstName,required this.lastName,required this.month,required this.day,required this.year,
    required this.email,required this.phoneNumber,required this.city, required this.state,required this.country,
    required this.occupation,required this.education,required this.salary,required this.dependents,
    required this.creditScore} );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'month': month,
      'day': day,
      'year': year,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'country': country,
      'occupation': occupation,
      'education': education,
      'salary': salary,
      'dependents': dependents,
      'creditScore': creditScore,
    };
  }
}