import 'package:flutter/material.dart';

class boxContainer extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;

  const boxContainer({
    required this.child,
    this.width = double.infinity, // Match parent width
    this.height = double.infinity, // Match parent height
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  @override
  State<boxContainer> createState() => _boxContainerState();
}

class _boxContainerState extends State<boxContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
              bottom: BorderSide(
                color: widget.borderColor,
                width: widget.borderWidth,
              ))),
      child: widget.child, // Place your desired widget inside the container
    );
  }
}