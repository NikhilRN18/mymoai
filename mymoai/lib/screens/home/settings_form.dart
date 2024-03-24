import 'package:flutter/material.dart';
import 'package:mymoai/services/database_user.dart';
import 'package:mymoai/shared/constants.dart';

import 'package:mymoai/models/user.dart';
import 'package:provider/provider.dart';

import 'package:mymoai/shared/loading.dart';

class SettingsForm extends StatefulWidget {

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> months = ["January","February","March","April","May","June",
    "July","August","September","October","November","December"];

  String? _currentFirstName;
  String? _currentLastName;
  int? _currentMonth;
  int? _currentDay;
  int? _currentYear;
  String? _currentEmail;
  int? _currentPhoneNumber;
  String? _currentCity;
  String? _currentState;
  String? _currentCountry;
  String? _currentOccupation;
  String? _currentEducation;
  int? _currentSalary;
  int? _currentDependents;
  int? _currentCreditScore;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseUser(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Update Your Profile Settings",style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                    initialValue: userData.firstName,
                    decoration: textInputDecoration.copyWith(hintText: 'First Name'),
                    onChanged: (val) {
                      setState(() => val != '' ? _currentFirstName = val : null);
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    initialValue: userData.lastName,
                    decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                    onChanged: (val) {
                      setState(() => val != '' ? _currentLastName = val : null);
                    }
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: months[userData.month!-1] ?? 'January',
                  items: months.map((month){
                    return DropdownMenuItem(
                      value: month ?? userData.month,
                      child: Text('$month'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentMonth = months.indexOf(val.toString())+1),
                ),
                Slider(
                  value: (_currentCreditScore ?? userData.creditScore).toDouble(),
                  activeColor: Colors.green[_currentCreditScore ?? userData.creditScore],
                  inactiveColor: Colors.green[_currentCreditScore ?? userData.creditScore],
                  min: 300.0,
                  max: 850.0,
                  onChanged: (val) => setState(() => _currentCreditScore = val.round()),
                ),
                ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent[100]),
                      child: Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        await DatabaseUser(uid: user?.uid).updateUserData(
                          _currentFirstName ?? userData.firstName,
                          _currentLastName ?? userData.lastName,
                          _currentMonth ?? userData.month,
                          _currentDay ?? userData.day,
                          _currentYear ?? userData.year,
                          _currentEmail ?? userData.email,
                          _currentPhoneNumber ?? userData.phoneNumber,
                          _currentCity ?? userData.city,
                          _currentState ?? userData.state,
                          _currentCountry ?? userData.country,
                          _currentOccupation ?? userData.occupation,
                          _currentEducation ?? userData.education,
                          _currentSalary ?? userData.salary,
                          _currentDependents ?? userData.dependents,
                          _currentCreditScore ?? userData.creditScore,
                        );
                        print(_currentFirstName);
                        print(_currentMonth);
                        print(_currentCreditScore);
                        Navigator.pop(context);
                      }
                    }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }

      }
    );
  }
}
