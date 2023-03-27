import 'package:flutter/material.dart';
import 'package:layouts/features/drawing/drawing_page.dart';
import 'package:layouts/features/home_screen.dart';
import 'package:layouts/features/processing/image_processing.dart';
import 'package:layouts/features/qr_code_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/qr-scanner": (context) => const QRCodeScanner(),
        "/image-processing": (context) => const ImageProcessing(),
        "/drawing-capabilities": (context) => DrawingPage(),
      },
    );
  }
}
