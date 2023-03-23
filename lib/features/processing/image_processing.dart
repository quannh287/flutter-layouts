import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layouts/utils/color_filter.dart';

class ImageProcessing extends StatefulWidget {
  const ImageProcessing({Key? key}) : super(key: key);

  @override
  State<ImageProcessing> createState() => _ImageProcessingState();
}

class _ImageProcessingState extends State<ImageProcessing> {
  ColorFilter _colorFiltered = ColorFilterMatrix.brightness.matrix;
  List<XFile>? _imageFileList;
  final ImagePicker _picker = ImagePicker();

  void _setImageFileList(XFile? file) {
    _imageFileList = file == null ? null : <XFile>[file];
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiple = false}) async {
    if (isMultiple) {
      final List<XFile> files = await _picker.pickMultiImage();
      setState(() {
        _imageFileList = files;
      });
    } else {
      final XFile? file = await _picker.pickImage(source: source);
      setState(() {
        _setImageFileList(file);
      });
    }
  }

  void _onChangeColorFilter(ColorFilter colorFilter) {
    log("_onChangeColorFilter");
    setState(() {
      _colorFiltered = colorFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Editor"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: _imageFileList == null
                    ? const Text(
                        "You must choose an image from your phone",
                        style: TextStyle(fontSize: 18),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blueGrey),
                        ),
                        child: ColorFiltered(
                          colorFilter: _colorFiltered,
                          child: Image(
                            image: FileImage(File(_imageFileList![0].path)),
                            height: 500,
                          ),
                        ),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              onPressed: () => _onImageButtonPressed(ImageSource.gallery, isMultiple: true),
              child: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
            ),
          ),
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
