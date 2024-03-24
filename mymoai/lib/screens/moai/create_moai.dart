import 'package:flutter/material.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:mymoai/shared/constants.dart';

import 'package:provider/provider.dart';
import 'package:mymoai/shared/loading.dart';

import 'package:mymoai/models/user.dart';
import 'package:flutter/services.dart';
import 'package:mymoai/services/moai_maker.dart';


class MoaiForm extends StatefulWidget {

  final AcctDetails acctDeets;
  MoaiForm({required this.acctDeets});

  @override
  State<MoaiForm> createState() => _MoaiFormState(acctDeets: acctDeets);
}

class _MoaiFormState extends State<MoaiForm> {
  AcctDetails acctDeets;
  _MoaiFormState({required this.acctDeets});

  final MakeMoai _auth = MakeMoai();
  final _formKey = GlobalKey<FormState>();
  final List<String> approvals = ['Public','Private'];
  bool loading = false;
  String error = '';

  String _currentName = '';
  String _description = '';
  int _memberMax = 10;
  int _premium = 0;
  String _approval = '';
  int _minSalary = 0;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.pinkAccent[100],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Update Your Profile Settings",
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: '',
                  decoration: textInputDecoration.copyWith(hintText: 'Moai Name'),
                  validator: (val) => val!.isEmpty ? "Enter a Moai Name" : null,
                  onChanged: (val) {
                    setState(() => _currentName = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: '',
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Brief Description'),
                  validator: (val) => val!.isEmpty ? "Enter a Description" : null,
                  onChanged: (val) {
                    setState(() => _description = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  initialValue: '',
                  decoration: textInputDecoration.copyWith(hintText: 'Max # of Members'),
                  validator: (val) => (int.tryParse(val!) == null || val!.isEmpty) ? "Enter an Integer" : null,
                  onChanged: (val) {
                    setState(() => _memberMax = int.parse(val)!);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  initialValue: '',
                  decoration: textInputDecoration.copyWith(hintText: 'Premium'),
                  validator: (val) => (int.tryParse(val!) == null || val!.isEmpty) ? "Enter an Integer" : null,
                  onChanged: (val) {
                    setState(() => _premium = int.parse(val)!);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: 'Public',
                  items: approvals.map((approval) {
                    return DropdownMenuItem(
                      value: approval,
                      child: Text('$approval'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _approval = val.toString()),
                ),
                Slider(
                  value: 0,
                  activeColor: Colors.green[_minSalary ?? 0],
                  inactiveColor: Colors.green[_minSalary ?? 0],
                  min: 0,
                  max: (acctDeets.salary ?? 20000).toDouble(),
                  divisions: 1000,
                  onChanged: (val) => setState(() => _minSalary = val.round()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent[100]),
                      child: Text('Create', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.makeMoai(
                              _currentName,
                              _description,
                              _memberMax,
                              _premium,
                              _approval,
                              _minSalary,
                              acctDeets,
                              user);
                          if (result == null) {
                            setState(() {
                              error = 'Error Creating Moai';
                              loading = false;
                            });
                          }
                          Navigator.pop(context);
                        }

                      },
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent[100]),
                      child: Text('Cancel', style: TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                SizedBox(height: 12.0),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
    );
  }
}