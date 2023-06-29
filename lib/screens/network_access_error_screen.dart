import 'package:flutter/material.dart';

class NetworkAccessErrorScreen extends StatelessWidget {
  const NetworkAccessErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                RotatedBox(
                  quarterTurns: 1,
                  child: Text('404',
                    style: TextStyle(
                      fontSize: 300,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent[700],
                      letterSpacing: -31,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                const Text(
                  'The application requires',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    overflow: TextOverflow.fade,
                  ),
                ),
            Text(
              'network  access'.toUpperCase(),
              maxLines: 2,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent[700],
                letterSpacing: -5,
                overflow: TextOverflow.fade,
              ),),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
