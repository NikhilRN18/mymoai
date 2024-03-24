import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymoai/services/database_user.dart';
import 'package:mymoai/shared/constants.dart';
import 'package:mymoai/models/user.dart';
import 'package:provider/provider.dart';
import 'package:mymoai/shared/loading.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SettingsForm extends StatefulWidget {


  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> months = ["January","February","March","April","May","June",
    "July","August","September","October","November","December"];
  bool loading = false;
  List<String> allInterests = ['Pets','Travel','Cars','Parties','Rentals'];

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
  List<String>? _currentMoais;
  List<String>? _currentInterests;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseUser(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              // title: Image.asset('assets/images/MyMoaiLogo.png'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0, // Set your desired width in pixels
                      height: 100.0, // Set your desired height in pixels
                      child: Image.asset('assets/images/MyMoaiLogo.png'),
                    ),
                    Text(
                      'User Information',
                      style: TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          TextFormField(
                              initialValue: userData.firstName,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                              ),
                              onChanged: (val) {
                                setState(() =>
                                val != '' ? _currentFirstName = val : null);
                              }
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                              initialValue: userData.lastName,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                              ),
                              onChanged: (val) {
                                setState(() =>
                                val != '' ? _currentLastName = val : null);
                              }
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Month'),
                              subtitle: DropdownButtonFormField(
                                value: months[userData.month! - 1] ?? 'January',
                                items: months.map((month) {
                                  return DropdownMenuItem(
                                    value: month ?? userData.month,
                                    child: Text('$month'),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() =>
                                _currentMonth =
                                    months.indexOf(val.toString()) + 1),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Day'),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: userData.day.toString(),
                                onChanged: (val) {
                                  setState(() => _currentDay = int.parse(val)!);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Year'),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: userData.year.toString(),
                                onChanged: (val) {
                                  setState(() => _currentYear = int.parse(val)!);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Phone Number'),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: userData.phoneNumber.toString(),
                                onChanged: (val) {
                                  setState(() => _currentPhoneNumber = int.parse(val)!);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('City'),
                              subtitle: TextFormField(
                                initialValue: userData.city,
                                onChanged: (val) {
                                  setState(() => _currentCity = val.isNotEmpty ? val : null);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('State'),
                              subtitle: TextFormField(
                                initialValue: userData.state,
                                onChanged: (val) {
                                  setState(() => _currentState = val.isNotEmpty ? val : null);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Country'),
                              subtitle: TextFormField(
                                initialValue: userData.country,
                                onChanged: (val) {
                                  setState(() => _currentCountry = val.isNotEmpty ? val : null);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Occupation'),
                              subtitle: TextFormField(
                                initialValue: userData.occupation,
                                onChanged: (val) {
                                  setState(() => _currentOccupation = val.isNotEmpty ? val : null);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Education'),
                              subtitle: TextFormField(
                                initialValue: userData.education,
                                onChanged: (val) {
                                  setState(() => _currentEducation = val.isNotEmpty ? val : null);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Salary'),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: userData.salary.toString(),
                                onChanged: (val) {
                                  setState(() => _currentSalary = int.parse(val)!);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Dependents'),
                              subtitle: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: userData.dependents.toString(),
                                onChanged: (val) {
                                  setState(() => _currentDependents = int.parse(val)!);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 20.0),
                          Card(
                            child: ListTile(
                              title: Text('Credit Score'),
                              subtitle: Slider(
                                value: (_currentCreditScore ??
                                    userData.creditScore).toDouble(),
                                activeColor: Colors.green[_currentCreditScore ??
                                    userData.creditScore],
                                inactiveColor: Colors
                                    .green[_currentCreditScore ??
                                    userData.creditScore],
                                min: 300.0,
                                max: 850.0,
                                divisions: 50,
                                label: _currentCreditScore != null ? "${ _currentCreditScore?.round().toString()}" : "",
                                onChanged: (val) => setState(() =>
                                _currentCreditScore = val.round()),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          // MultiSelectDialogField(
                          //   initialValue: [],
                          //   items: allInterests.map((e) => MultiSelectItem(e, e.toString())).toList(),
                          //   listType: MultiSelectListType.CHIP,
                          //   onConfirm: (values) {
                          //     _currentInterests = values.map((e) => (e.toString())).toList();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    MaterialButton(
                        color: Color(0xFFFFFD1DC),
                        child: Text('Save Changes'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
