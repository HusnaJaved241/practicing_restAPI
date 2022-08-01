import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsingPhotosApi extends StatelessWidget {
  UsingPhotosApi({Key? key}) : super(key: key);
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> fetchPhotoApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        photosList.add(
          PhotosModel(
              id: i['id'],
              title: i['title'],
              url: i['url'],
              thumbnail: i['thumbnail']),
        );
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example 2'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchPhotoApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          subtitle: Text(photosList[index].title),
                          title: Text(photosList[index].id.toString()),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              photosList[index].url,
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosModel {
  final int id;
  final String title, url, thumbnail;

  PhotosModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.thumbnail});
}
