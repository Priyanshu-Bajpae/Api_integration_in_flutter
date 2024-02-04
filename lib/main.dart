import 'package:flutter/material.dart';
//import 'package:flutter_tute2/photo_api.dart';
//import 'package:flutter_tute2/post_api.dart';
//import 'package:flutter_tute2/user_api.dart';
//import 'package:flutter_tute2/without_model.dart';
import 'package:flutter_tute2/complex_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: // const PhotoApi(),
          //const PostApi(),
          //const UserApi(),
          //const WithoutModel(),
          const ComplexApi(),
    );
  }
}
