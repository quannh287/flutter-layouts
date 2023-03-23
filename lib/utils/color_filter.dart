import 'dart:ui';

import 'package:flutter/foundation.dart';

enum ColorFilterMatrix {
  grayscale,
  sepia,
  invert,
  brightness,
  contrast,
  mosaic,
}

extension ColorFilterMatrixExt on ColorFilterMatrix {
  String get name => describeEnum(this);

  ColorFilter get matrix {
    switch (this) {
      case ColorFilterMatrix.grayscale:
        return const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case ColorFilterMatrix.sepia:
        return const ColorFilter.matrix(<double>[
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ]);

      case ColorFilterMatrix.invert:
        return const ColorFilter.matrix(<double>[
          -1, 0, 0, 0, 255,
          0, -1, 0, 0, 255,
          0, 0, -1, 0, 255,
          0, 0, 0, 1, 0,
        ]);

      case ColorFilterMatrix.brightness:
        return const ColorFilter.matrix(<double>[
          1, 0, 0, 0, 50,
          0, 1, 0, 0, 50,
          0, 0, 1, 0, 50,
          0, 0, 0, 1, 0,
        ]);

      case ColorFilterMatrix.contrast:
        return const ColorFilter.matrix(<double>[
          2, 0, 0, 0, -255,
          0, 2, 0, 0, -255,
          0, 0, 2, 0, -255,
          0, 0, 0, 1, 0,
        ]);

      case ColorFilterMatrix.mosaic:
        return const ColorFilter.matrix(<double>[
          2, 0, 0, 0, -255,
          0, 2, 0, 0, -255,
          0, 0, 2, 0, -255,
          0, 0, 0, 1, 0,
        ]);

      default:
        return const ColorFilter.matrix(<double>[
          1, 0, 0, 0, 50,
          0, 1, 0, 0, 50,
          0, 0, 1, 0, 50,
          0, 0, 0, 1, 0,
        ]);
    }
  }
}
