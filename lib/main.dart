import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:layouts/features/chart/gantt_chart.dart';
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
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/qr-scanner": (context) => const QRCodeScanner(),
        "/image-processing": (context) => const ImageProcessing(),
        "/drawing-capabilities": (context) => DrawingPage(),
        "/gantt-chart": (context) => const GanttChart(),
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad
    // etc.
  };
}
