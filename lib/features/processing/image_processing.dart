import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageProcessing extends StatefulWidget {
  const ImageProcessing({Key? key}) : super(key: key);

  @override
  State<ImageProcessing> createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Image Processing"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _onImageButtonPressed(
            ImageSource.gallery,
            context: context,
            isMultiImage: true,
          )
        },
        child: const Icon(
          Icons.upload_file_outlined,
          color: Colors.white,
        ),
      ),
    );
  }


}
