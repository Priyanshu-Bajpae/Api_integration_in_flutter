import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoApi extends StatefulWidget {
  const PhotoApi({super.key});

  @override
  State<PhotoApi> createState() => _PhotoApiState();
}

class _PhotoApiState extends State<PhotoApi> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map m in data) {
        Photos photos = Photos(title: m['title'], url: m['url'], id: m['id']);
        photosList.add(photos);
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
        centerTitle: true,
        title: const Text(' Photo Api Calling'),
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data![index].toString()),
                          ),
                          subtitle:
                              Text(snapshot.data![index].title.toString()),
                          title: Text(
                              'Notes Id:${snapshot.data![index].id.toString()}'),
                        );
                      }
                    });
              }),
        )
      ]),
    );
  }
}

//Photo Model
class Photos {
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
