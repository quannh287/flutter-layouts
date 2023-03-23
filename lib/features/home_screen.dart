import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layouts/features/processing/video_editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  void _pickVideo() async {
    /*final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => VideoEditor(file: File(pickedFile.path)),
        ),
      );
    }*/
  }

  void navigateToScreen(BuildContext context, String screenName) {
    Navigator.pushNamed(context, screenName);
  }

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
              onPressed: () => navigateToScreen(context, "/qr-scanner"),
              child: const Text('QR Code Screen'),
            ),
            ElevatedButton(
              onPressed: () => navigateToScreen(context, "/image-processing"),
              child: const Text('Image Processing'),
            ),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Video Editor'),
            ),
          ],
        ),
      ),
    );
  }
}
