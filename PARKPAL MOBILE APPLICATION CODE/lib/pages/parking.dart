import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'slotWidget.dart';

class Parking extends StatefulWidget {

  final int data1;
  final int data2;
  final int data3;
  final int data4;


  Parking({super.key, required this.data1, required this.data2, required this.data3, required this.data4});

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  final List slot1 = [0,1,0];

  final List slot2 = [0,0,1];

  var cnt = 0;

  @override
  Widget build(BuildContext context) {

    slot1[0] = widget.data1;
    slot1[2] = widget.data2;
    slot2[0] = widget.data3;
    slot2[1] = widget.data4;

    for (var i in slot1) {
      if(i==0){
        cnt +=1;
      }
    }

    for (var i in slot2) {
      if(i==0){
        cnt +=1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Center(
                child: Text('Select a Slot',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat Bold',
                        fontSize: 35))),
          ),
           Padding(
             padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
             child: Text('$cnt available slots',
                style: TextStyle(
                    fontFamily: 'Montserrat ExtraLight',
                    fontSize: 16,
                    letterSpacing: 1.1,
                    color: Color.fromARGB(255, 135, 233, 248))),
           ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: slot1.map((e) => slotWidget(slot: e)).toList(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 95),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                        child: Image.asset('assets/images/arrow.png'),
                      ),
                    ],
                  ),
                  Column(
                    children: slot2.map((e) => slotWidget(slot: e)).toList(),
                  ),
                ],
              ),
            ),
          //   Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          //   child: ElevatedButton(
          //           onPressed: () {},
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Color.fromARGB(255, 89, 196, 241),
          //             minimumSize: const Size(250, 70),
          //             shape: RoundedRectangleBorder(
          //               borderRadius:
          //                   BorderRadius.circular(30), // Adjust corner radius
          //             ),
          //           ),
          //           child: const Text(
          //             'Start Parking',
          //             style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Montserrat Medium', letterSpacing: 1.3),
          //           ),
          //         ),
          // ),
          ],
        ),
      ),
    );
  }
}
