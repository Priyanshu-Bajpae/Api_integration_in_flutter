import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModel extends StatefulWidget {
  const WithoutModel({super.key});

  @override
  State<WithoutModel> createState() => _WithoutModelState();
}

class _WithoutModelState extends State<WithoutModel> {
  var data;
  Future<void> getComplexApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex API Calling without using plugin Model'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getComplexApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'name:',
                                      value: data[index]['name'].toString()),
                                  ReusableRow(
                                      title: 'username:',
                                      value:
                                          data[index]['username'].toString()),
                                  const Text(
                                    'Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ReusableRow(
                                      title: 'city:',
                                      value: data[index]['address']['city']
                                          .toString()),
                                  ReusableRow(
                                      title: 'street:',
                                      value: data[index]['address']['street']
                                          .toString()),
                                  ReusableRow(
                                      title: 'zipcode:',
                                      value: data[index]['address']['zipcode']
                                          .toString()),
                                  ReusableRow(
                                      title: 'geo',
                                      value: data[index]['address']['geo']
                                              ['lat'] // all sub values of geo will be displayed if ['lat'] is not mentioned
                                          .toString()),
                                ],
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
