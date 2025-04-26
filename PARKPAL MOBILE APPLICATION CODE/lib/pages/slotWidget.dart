import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'box.dart';

class slotWidget extends StatefulWidget {
  
  final int slot;
  slotWidget({required this.slot});

  @override
  State<slotWidget> createState() => _slotWidgetState();
}

class _slotWidgetState extends State<slotWidget> {
  @override
  Widget build(BuildContext context) {

    Widget childwidget;

    if(widget.slot == 0){
      childwidget = Center(child: Text("Available", style: TextStyle(color: Colors.white),));
    }
    else{
      childwidget = Image.asset('assets/images/car.png');
    }

    return boxContainer(
      child: childwidget,
      width: 150.0, // Set a specific width
      height: 130.0, // Set a specific height
      borderColor: const Color.fromARGB(255, 255, 255, 255), // Change the border color
      borderWidth: 2.0,
    );
  }
}