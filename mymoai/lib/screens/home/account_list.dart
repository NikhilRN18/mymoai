import 'package:flutter/material.dart';
import 'package:mymoai/models/acctdetails.dart';
import 'package:provider/provider.dart';
import 'package:mymoai/screens/home/account_tile.dart';

class AccountList extends StatefulWidget {

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    final acctDeets = Provider.of<List<AcctDetails>>(context) ?? [];

    return ListView.builder (
        itemCount: acctDeets.length,
        itemBuilder: (context,index) {
          return AcctTile(acct: acctDeets[index]);
        }
    );
  }
}
