import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DestinationPage extends StatefulWidget {
  final String data;

  const DestinationPage({required this.data});

  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  late String receivedData;

  @override
  void initState() {
    super.initState();
    receivedData = widget.data; // Access the data passed from the source page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destination Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Received Data: $receivedData'),
          ],
        ),
      ),
    );
  }
}
