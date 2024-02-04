import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tute2/models/complex_model.dart';
import 'package:http/http.dart' as http;

class ComplexApi extends StatefulWidget {
  const ComplexApi({super.key});

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {
  Future<ComplexModel> getComplexApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/aecd25cb-b010-42bf-8877-bcfe3b80a39b'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ComplexModel.fromJson(data);
    } else {
      return ComplexModel.fromJson(data);
      //throw Exception('Failed to get data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Data Fetching'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ComplexModel>(
                future: getComplexApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.data?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot
                                    .data!.data![index].shop!.name
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.data![index].shop!.shopemail
                                    .toString()),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data![index].shop!.image
                                        .toString())),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .data![index]
                                                      .images![position]
                                                      .url
                                                      .toString()))),
                                        ),
                                      );
                                    }),
                              ),
                              Icon(
                                  snapshot.data!.data![index].inWishlist == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline),
                            ],
                          );
                        });
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
