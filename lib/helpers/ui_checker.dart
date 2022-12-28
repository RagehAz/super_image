import 'dart:typed_data';
import 'dart:ui' as ui show Image;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:super_image/helpers/helpers.dart';

// --------------------
/// TESTED : WORKS PERFECT
Future<ui.Image> getUiImageFromUint8List(Uint8List uInt) async {
  ui.Image _decodedImage;

  if (uInt != null) {
    await tryAndCatch(
      invoker: 'getUiImageFromUint8List',
      functions: () async {
        _decodedImage = await decodeImageFromList(uInt);
      },
    );
  }

  return _decodedImage;
}

// --------------------
/// TESTED : WORKS PERFECT
bool objectIsUiImage(dynamic object){
  bool _isUiImage = false;

  if (object != null){

    if (object is ui.Image){
      _isUiImage = true;
    }

  }

  return _isUiImage;
}
