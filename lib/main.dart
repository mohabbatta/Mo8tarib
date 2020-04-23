import 'package:flutter/material.dart';
import 'package:mo8tarib/Screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp (

     title: "Mo8tarib",
     home: home(),

   );
  }
}