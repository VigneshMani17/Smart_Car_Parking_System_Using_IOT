
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages/parking.dart';
import 'pages/loading.dart';
import 'pages/home.dart';
import 'pages/bluetooth.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) =>  Home(),
      '/bluetooth':(context) => MainApp()
    },
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 89, 196, 241)),
        useMaterial3: true,
      )
  ));
}

