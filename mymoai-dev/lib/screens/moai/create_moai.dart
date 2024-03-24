import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:mymoai/screens/search/search.dart';
import 'package:mymoai/services/database_user.dart';
import 'package:provider/provider.dart';
import 'package:mymoai/shared/loading.dart';
import 'package:mymoai/services/auth.dart';
import 'package:mymoai/models/user.dart';
import 'package:flutter/services.dart';
import 'package:mymoai/services/moai_maker.dart';

import 'moaiinfo.dart';


class MoaiForm extends StatefulWidget {

  final AcctDetails acctDeets;
  MoaiForm({required this.acctDeets});

  @override
  State<MoaiForm> createState() => _MoaiFormState(acctDeets: acctDeets);
}

class _MoaiFormState extends State<MoaiForm> {

  AcctDetails acctDeets;
  _MoaiFormState({required this.acctDeets});

  final AuthService _auth = AuthService();
  final MakeMoai _moai = MakeMoai();
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

    void _signOut() async {
      await _auth.signOut();
    }

    Future<AcctDetails> _getAcctDeets() async {
      String uid = await _auth.currentUser();
      return await DatabaseUser().getAccountDetails(uid);
    }

    return MaterialApp(
      home: loading ? Loading() : Scaffold(
        appBar: AppBar(
          // title: Image.asset('assets/images/MyMoaiLogo.png'),
          centerTitle: true,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 412,
              maxHeight: 915,
            ),
            child: Padding(
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
                      'Create A Moai',
                      style: TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Moai Name',
                            ),
                            validator: (val) => val!.isEmpty ? "Enter a Moai Name" : null,
                            onChanged: (val) {
                              setState(() => _currentName = val);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Brief Description',
                            ),
                            validator: (val) => val!.isEmpty ? "Enter a Description" : null,
                            onChanged: (val) {
                              setState(() => _description = val);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            initialValue: '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Max # of Members',
                            ),
                            validator: (val) => (int.tryParse(val!) == null || val!.isEmpty) ? "Enter an Integer" : null,
                            onChanged: (val) {
                              setState(() => _memberMax = int.parse(val)!);
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            initialValue: '',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Premium',
                            ),
                            validator: (val) => (int.tryParse(val!) == null || val!.isEmpty) ? "Enter an Integer" : null,
                            onChanged: (val) {
                              setState(() => _premium = int.parse(val)!);
                            },
                          ),
                          SizedBox(height: 20),
                          Card(
                            child: ListTile(
                              title: Text('Approval Setting'),
                              subtitle: DropdownButtonFormField(
                                value: 'Public',
                                items: approvals.map((approval) {
                                  return DropdownMenuItem(
                                    value: approval,
                                    child: Text('$approval'),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() => _approval = val.toString()),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Card(
                            child: ListTile(
                              title: Text('Minimum Salary'),
                              subtitle: Slider(
                                value: _minSalary.toDouble(),
                                activeColor: Colors.green[(1000*_minSalary/acctDeets.salary).round()],
                                inactiveColor: Colors.green[(1000*_minSalary/acctDeets.salary).round()],
                                min: 0,
                                max: (acctDeets.salary).toDouble(),
                                divisions: 1000,
                                label: "\$ ${_minSalary.round().toString()}",
                                onChanged: (val) => setState(() => _minSalary = val.round()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      color: Color(0xFFFFFD1DC),
                      child: Text('Create'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _moai.makeMoai(
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
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFff7f50),
          backgroundColor: Color(0xFFFFD1DC),
          unselectedItemColor: Color(0xFFC2185B),
          currentIndex: 3, // This highlights the third item, which is "Build Moai"
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.database),
              label: 'My Moais',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create Moai',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Log Out',
            ),
          ],
          onTap: (value) async {
            if (value == 0) { // My Moais
              loading = true;
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoaiInfo()));
            }
            if (value == 1) { // Search
              loading = true;
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Search()));
            }
            if (value == 2) { // Dashboard
              loading = true;
              Navigator.pop(context);
            }
            if (value == 3) { // Create Moai
              loading = false;
            }
            if (value == 4) { // Log Out
              Navigator.pop(context);
              _signOut();
            }
          },
        ),
      ),
    );
  }
}
