import 'dart:convert';

import 'package:api_practice_2/models/name_model.dart';
import 'package:api_practice_2/new_page.dart';
import 'package:country_code/country_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictNationality extends StatefulWidget {
  PredictNationality({Key? key}) : super(key: key);

  @override
  State<PredictNationality> createState() => _PredictNationalityState();
}

class _PredictNationalityState extends State<PredictNationality> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Nationality'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      showAlertDialog(nameString: controller.text),
                );
              },
              child: Text('Let\'s  find out'),
            ),
          ],
        ),
      ),
    );
  }
}

String FromPercentageString(double value) {
  return (value * 100).round().toString() + "%";
}

Widget customRow(String text1, String text2) {
  return Row(
    children: [
      Text(
        text1,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        text2,
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
    ],
  );
}

class showAlertDialog extends StatelessWidget {
  final nameString;

  Future<NameModel> fetchNationality(String name) async {
    final response = await http.get(
      Uri.parse('https://api.nationalize.io/?name=$name'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      NameModel name = NameModel.fromJson(data);
      return name;
    } else {
      throw Exception('Sorry! Unable to find name:(');
    }
  }

  const showAlertDialog({Key? key, required this.nameString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: 100.0,
      ),
      backgroundColor: Color.fromARGB(255, 228, 196, 184),
      contentPadding: const EdgeInsets.all(10.0),
      content: FutureBuilder<NameModel>(
        future: fetchNationality(nameString),
        builder: ((context, AsyncSnapshot<NameModel> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[400],
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                    child: ListTile(
                      title: customRow(
                        'Name: ',
                        snapshot.data!.name.toString(),
                      ),
                    ),
                  ),
                  for (Country country in snapshot.data!.country!)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        shape: RoundedRectangleBorder(),
                        title: Column(
                          children: [
                            customRow(
                              'Country Id: ',
                              CountryCode.parse(country.countryId.toString())
                                      .symbol +
                                  " " +
                                  CountryCode.parse(
                                          country.countryId.toString())
                                      .alpha3,
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
                            customRow(
                              'Probability: ',
                              FromPercentageString(
                                double.parse(
                                  country.probability!.toString(),
                                ),
                              ).toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
            // Ottogkue
          } else if (snapshot.data == 'Sorry! Unable to find name:(') {
            return Center(
              child: Text(
                'Sorry! Name not found:(',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Sorry! Name not found:(',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Sorry! Name not found:(',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        }),
      ),
      title: Text(
        'How accurate is our prediction?',
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Try again'))
      ],
    );
  }
}
