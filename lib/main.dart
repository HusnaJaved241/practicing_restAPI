import 'package:api_practice_2/example_2.dart';
import 'package:api_practice_2/name_prediction.dart';
import 'package:flutter/material.dart';

import 'example_3.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home:  PredictNationality(),
    );
  }
}



