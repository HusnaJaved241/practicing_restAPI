import 'dart:convert';
import 'dart:ffi';

import 'package:api_practice_2/constants.dart';
import 'package:dart_countries/dart_countries.dart' as imp;
import 'package:country_code/country_code.dart';
import 'package:flutter/material.dart';

import 'name_prediction.dart';
import 'models/name_model.dart';
import 'package:http/http.dart' as http;

class NewPage extends StatelessWidget {
  final nameString;
  NewPage({
    Key? key,
    required this.nameString,
  }) : super(key: key);
  Future<NameModel> fetchNationality(String name) async {
    final response = await http.get(
      Uri.parse('https://api.nationalize.io/?name=$name'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      NameModel name = NameModel.fromJson(data);
      return name;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: AlertDialog(
            backgroundColor: Color(0xFFE9BCAB),
            contentPadding: const EdgeInsets.all(10.0),
            content: FutureBuilder<NameModel>(
              future: fetchNationality(nameString),
              builder: ((context, AsyncSnapshot<NameModel> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customRow(
                            'Name: ',
                            snapshot.data!.name.toString(),
                          ),
                          for (Country country in snapshot.data!.country!)
                            Column(
                              children: [
                                customRow(
                                  'Country Id: ',
                                  CountryCode.parse(
                                              country.countryId.toString())
                                          .symbol +
                                      " " +
                                      CountryCode.parse(
                                              country.countryId.toString())
                                          .alpha3,
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
                        ],
                      ),
                    ),
                  );
                  // Ottogkue
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Something went wrong:(',
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
          ),
        ),
      ),
    );
  }
}


