import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layouts/utils/color_filter.dart';
import 'package:layouts/utils/filter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImageProcessing extends StatefulWidget {
  const ImageProcessing({Key? key}) : super(key: key);

  @override
  State<ImageProcessing> createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  ColorFilter _colorFiltered = ColorFilterMatrix.brightness.matrix;
  File? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  Future<Uint8List>? _futureString;

  Future<void> _onImageButtonPressed(ImageSource source, {bool isMultiple = false}) async {
    final XFile? file = await _picker.pickImage(source: source);
    _futureString = Future.delayed(
        const Duration(seconds: 1), () => FilterMethods.getFilteredImage(_pickedFile!));

    setState(() {
      _pickedFile = File(file!.path);
    });
  }

  void _onChangeColorFilter(ColorFilter colorFilter) {
    log("_onChangeColorFilter");
    setState(() {
      _colorFiltered = colorFilter;
    });
  }

  Future<void> _applyFilter() async {
    List<int> imageBytes = await _pickedFile!.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

    img.Image filteredImage =
        img.copyResize(originalImage!, width: originalImage.width, height: originalImage.height);
    img.billboard(filteredImage);

    Directory? appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir!.path;

    String fileName = 'quan-${DateTime.now().millisecondsSinceEpoch}_filtered.jpg';
    File filteredFile = File('$appDocPath/$fileName');
    compute(filteredFile.writeAsBytes, img.encodePng(filteredImage));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image saved to $appDocPath'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Editor"),
        actions: [
          IconButton(
            onPressed: _applyFilter,
            icon: const Icon(
              Icons.download_for_offline_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: _pickedFile == null
                    ? const Text(
                        "You must choose an image from your phone",
                        style: TextStyle(fontSize: 18),
                      )
                    : FutureBuilder(
                        future: _futureString,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.blueGrey),
                              ),
                              child: Image.memory(snapshot.data!),
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "List filters",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ColorFilterMatrix.values.length,
                    itemBuilder: (BuildContext context, int index) => _filterItem(
                        ColorFilterMatrix.values[index].name,
                        () => _onChangeColorFilter(ColorFilterMatrix.values[index].matrix)),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _onImageButtonPressed(ImageSource.gallery),
            child: const Icon(
              Icons.photo,
              color: Colors.white,
            ),
          ),
/*          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              onPressed: () => _onImageButtonPressed(ImageSource.gallery, isMultiple: true),
              child: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              onPressed: () => _onImageButtonPressed(ImageSource.camera),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterItem(String itemName, void Function()? callback) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: callback,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                itemName.toCapitalize(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
