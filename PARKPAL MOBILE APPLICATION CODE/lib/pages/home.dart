
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset(
              'assets/images/intro.png',
              width: 500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 30, 0, 0),
            child: Text(
              'ParkPal',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Michroma',
                  letterSpacing: 3),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: Text(
              'Your Parking Partner',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bluetooth');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 89, 196, 241),
                    minimumSize: const Size(300, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Adjust corner radius
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
