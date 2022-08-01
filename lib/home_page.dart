import 'dart:convert';

import 'package:api_practice_2/constants.dart';
import 'package:api_practice_2/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Let\'s Try Again',
            style: GoogleFonts.acme(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: ((context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFFF1C9BB)),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 30.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title:',
                                style: kHeadingTextStyle,
                              ),
                              Text(
                                postList[index].title.toString(),
                                style: kNormalTextStyle,
                              ),
                              Text(
                                'Body:',
                                style: kHeadingTextStyle,
                              ),
                              Text(
                                postList[index].body.toString(),
                                style: kNormalTextStyle,
                              ),
                            ],
                          ),
                        );
                      }),
                      itemCount: 10,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                future: getPostApi(),
              ),
            ),
          ],
        ));
  }
}










// "this is not going to be fun "
// why the hell am i wasting so much time
// everytime it gets difficult...I just start loosing motivation ..Whyyyyyyyyyyyy whhyyy 
// it should not be happening
// how could i motivate myself
// ottoogwyeeee

// What am i gonna doooooooooo
// for the first timein foreverrrr..there will be music there will be fun,, for the first time in forevereee...atleat i have got a chance to meet the oneee
