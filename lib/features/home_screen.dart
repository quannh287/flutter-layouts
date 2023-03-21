import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Home Screen", textAlign: TextAlign.center),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/qr-scanner');
            },
            child: Text('QR Code Screen'),
          ),
        ],
      ),
    );
  }
}
