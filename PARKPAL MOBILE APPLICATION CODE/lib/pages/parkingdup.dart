import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Parking extends StatelessWidget {
  const Parking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
                child: Text('Select a Slot',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat Bold',
                        fontSize: 35))),
          ),
          const Text('4 available slots',
              style: TextStyle(
                  fontFamily: 'Montserrat ExtraLight',
                  fontSize: 18,
                  letterSpacing: 1.2,
                  color: Color.fromARGB(255, 152, 152, 152))),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/line.png'),
                Image.asset('assets/images/line.png'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/car.png'),
                Image.asset('assets/images/arrow.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Text('Available', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/line.png'),
                Image.asset('assets/images/line.png'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text('Available', style: TextStyle(color: Colors.white),),
                ),
                Image.asset('assets/images/arrow.png'),
                Image.asset('assets/images/car.png'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/line.png'),
                Image.asset('assets/images/line.png'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Text('Available', style: TextStyle(color: Colors.white),),
                ),
                Image.asset('assets/images/arrow.png'),
                Image.asset('assets/images/car.png'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/line.png'),
                Image.asset('assets/images/line.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 89, 196, 241),
                      minimumSize: const Size(250, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Adjust corner radius
                      ),
                    ),
                    child: const Text(
                      'Start Parking',
                      style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: 'Montserrat Medium', letterSpacing: 1.3),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}