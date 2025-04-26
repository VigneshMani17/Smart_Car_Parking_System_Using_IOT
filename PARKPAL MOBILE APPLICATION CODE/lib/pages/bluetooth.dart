import 'package:flutter/material.dart';
import 'mainpage.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 139, 220, 255)),),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

