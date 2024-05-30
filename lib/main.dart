import 'package:flutter/material.dart';
import 'package:projects/screen/animated_add_delete_item.dart';
import 'package:projects/screen/custome_scrollview.dart';
import 'package:projects/screen/home_screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  AnimatedAddDeleteItemScreen(),
    );
  }
}
