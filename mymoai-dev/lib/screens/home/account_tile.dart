import 'package:flutter/material.dart';
import 'package:mymoai/models/acctdetails.dart';

class AcctTile extends StatelessWidget {

  final AcctDetails acct;
  AcctTile( {required this.acct} );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green[acct.creditScore],
          ),
          title: Text(acct.firstName + ' ' + acct.lastName),
          subtitle: Text(acct.email),
        ),
      )
    );
  }
}
