import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

class FilterMethods {
  static Future<Uint8List> adjust(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    img.Image filteredImg = img.decodeImage(Uint8List.fromList(imageBytes))!;

    img.billboard(filteredImg);
    final pngBytes = img.encodePng(filteredImg);

    return pngBytes;
  }

  static Future<Uint8List> getFilteredImage(File image, {dynamic filterType}) async {
    // if (filterType == null) {
    //   return (await image.readAsBytes());
    // }
    return compute(adjust, image);
  }
}
