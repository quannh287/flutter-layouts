import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/qr-scanner');
              },
              child: Text('QR Code Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/image-processing');
              },
              child: Text('Image Processing'),
            ),
          ],
        ),
      ),
    );
  }
}
