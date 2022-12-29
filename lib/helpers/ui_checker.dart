import 'dart:ui' as ui show Image;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:super_image/helpers/helpers.dart';
import 'dart:typed_data';

// --------------------
/// TESTED : WORKS PERFECT
Future<ui.Image> getUiImageFromUint8List(Uint8List bytes) async {
  ui.Image _decodedImage;

  if (bytes != null) {
    await tryAndCatch(
      invoker: 'getUiImageFromUint8List',
      functions: () async {
        _decodedImage = await decodeImageFromList(bytes);
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
