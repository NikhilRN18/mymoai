import 'package:csv/csv.dart';
import 'package:mymoai/services/auth.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/csv/people.csv');
}

Future<void> populateDatabase() async {
  final csvString = await loadAsset();
  final AuthService _auth = AuthService();
  List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

  // Assuming the first row is the header
  List<String> headers = csvData.removeAt(0).cast<String>();

  for (var row in csvData) {
    Map<String, dynamic> data = Map.fromIterables(headers, row);

    await _auth.registerEmail(
      data['email'],
      'qwerty',
      data['firstName'],
      data['lastName'],
      data['month'],
      data['day'],
      data['year'],
      data['phoneNumber'],
      data['city'],
      data['state'],
      data['country'],
      data['occupation'],
      data['education'],
      data['salary'],
      data['dependents'],
      data['creditScore'],
      true,
    );
  }
  print("Done");
}
