import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dest.dart';

class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  String dataToSend = "Data 1 ";

  void navigateToDestination() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DestinationPage(data: dataToSend),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Data to Send: $dataToSend'),
            ElevatedButton(
              onPressed: navigateToDestination,
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
