import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

// -----------------------------------------------------------------------------

/// NOTIFIER

// --------------------
/// TESTED : WORKS PERFECT
void setNotifier({
  @required ValueNotifier<dynamic> notifier,
  @required bool mounted,
  @required dynamic value,
  bool addPostFrameCallBack = false,
  Function onFinish,
  bool shouldHaveListeners = false,
}){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
            if(onFinish != null){
              onFinish();
            }
          }

        }

      }

    }

  }

}
// -----------------------------------------------------------------------------

/// MAPPERS

// --------------------
/// TESTED : WORKS PERFECT
bool checkCanLoopList(List<dynamic> list) {
  bool _canLoop = false;

  if (list != null && list.isNotEmpty) {
    _canLoop = true;
  }
  return _canLoop;
}
// --------------------
/// TESTED : WORKS PERFECT
bool checkListsAreIdentical({
  @required List<dynamic> list1,
  @required List<dynamic> list2
}) {
  bool _listsAreIdentical = false;

  if (list1 == null && list2 == null){
    _listsAreIdentical = true;
  }
  else if (list1?.isEmpty == true && list2?.isEmpty == true){
    _listsAreIdentical = true;
  }

  else if (checkCanLoopList(list1) == true && checkCanLoopList(list2) == true){

    if (list1.length != list2.length) {
// blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
// blog(' ---> lis1 is ( ${list1.toString()} )');
// blog(' ---> lis2 is ( ${list2.toString()} )');
      _listsAreIdentical = false;
    }

    else {
      for (int i = 0; i < list1.length; i++) {

        if (list1[i] != list2[i]) {
// blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');
          _listsAreIdentical = false;
          break;
        }

        else {
          _listsAreIdentical = true;
        }

      }
    }

  }

  return _listsAreIdentical;
}
// -----------------------------------------------------------------------------

/// FLOATERS

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
Future<ByteData> getByteDataFromPath(String assetPath) async {
  /// NOTE : Asset path can be local path or url
  ByteData _byteData;

  if (stringIsEmpty(assetPath) == false){
    _byteData = await rootBundle.load(assetPath);
  }

  return _byteData;
}
// -----------------------------------------------------------------------------

/// ERROR HELPERS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> tryAndCatch({
  @required Function functions,
  String invoker,
  ValueChanged<String> onError,
}) async {

  try {
    await functions();
  }

  on Exception catch (error) {

    if (onError != null) {
      onError(error.toString());
    }

    // throw(error);
  }

}
// -----------------------------------------------------------------------------

/// OBJECT CHECKERS

// --------------------
/// TESTED : WORKS PERFECT
bool isAbsoluteURL(dynamic object) {
  bool _isValidURL = false;

  if (object != null && object is String) {
    // ----------------------------------
    /*
      /// INITIAL CHECK
      final bool _startsWithHttp = TextCheck.textStartsWithAny(
        text: object,
        listThatMightIncludeText: <String>['h', 'ht','htt','http',],
      );
      final bool _startsWithWWW = TextCheck.textStartsWithAny(
        text: object,
        listThatMightIncludeText: <String>['www', 'ww','w'],
      );
      if (_startsWithHttp == true || _startsWithWWW == true){
        _isValidURL = true;
      }
       */
    // ----------------------------------
    /// - EXTRA CHECK
    // if (_isValidURL == false){

    _isValidURL = Uri.parse(object).isAbsolute;

    // }
    ///
    // ----------------------------------
  }

  return _isValidURL;
}
// --------------------
/// TESTED : WORKS PERFECT
extension FileExtention on FileSystemEntity {
  String get fileNameWithExtension {
    return this?.path?.split('/')?.last;
  }

  // -----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split('.')?.last;
  }
}
// --------------------
/// TESTED : WORKS PERFECT
String fileExtensionOf(dynamic file) {

  if (file == null){
    return null;
  }
  else if (file is String){
    return File(file).fileExtension;
  }
  else {
    return null;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
bool objectIsJPGorPNG(dynamic object) {
  bool _objectIsJPGorPNG = false;

  if (object != null){
    if (
        fileExtensionOf(object) == 'jpeg'
        ||
        fileExtensionOf(object) == 'jpg'
        ||
        fileExtensionOf(object) == 'png'
    ) {
      _objectIsJPGorPNG = true;
    }

    else {
      _objectIsJPGorPNG = false;
    }

  }

  return _objectIsJPGorPNG;
}
// --------------------
/// TESTED : WORKS PERFECT
bool objectIsSVG(dynamic object) {
  bool _isSVG = false;

  if (fileExtensionOf(object) == 'svg') {
    _isSVG = true;
  }

  else {
    _isSVG = false;
  }

  return _isSVG;
}
// --------------------
/// TESTED : WORKS PERFECT
bool objectIsFile(dynamic file) {
  bool _isFile = false;

  if (file != null) {

    final bool isFileA = file is File;
    final bool isFileB = file.runtimeType.toString() == '_File';

    if (isFileA == true || isFileB == true) {
      _isFile = true;
    }

  }

  // else {
  //   blog('objectIsFile : isFile : null');
  // }

  return _isFile;
}
// --------------------
/// TESTED : WORKS PERFECT
bool objectIsUint8List(dynamic object) {
  bool _isUint8List = false;

  if (object != null) {
    if (
        object is Uint8List
        ||
        object.runtimeType.toString() == '_Uint8ArrayView'
        ||
        object.runtimeType.toString() == 'Uint8List'
    ) {
      _isUint8List = true;
    }
  }

  return _isUint8List;
}
// --------------------
/// TESTED : WORKS PERFECT
bool isBase64(dynamic value) {

  if (value is String == true) {

    final RegExp rx = RegExp(
        r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$',
        multiLine: true,
        unicode: true);

    final bool isBase64Valid = rx.hasMatch(value);

    if (isBase64Valid == true) {
      return true;
    }

    else {
      return false;
    }

  }

  else {
    return false;
  }

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
// --------------------
/// TESTED : WORKS PERFECT
bool objectIsImgImage(dynamic object){
  bool _isImgImage = false;

  if (object != null){

    if (object is img.Image){
      _isImgImage = true;
    }

  }

  return _isImgImage;
}
// --------------------
/// TESTED : WORKS PERFECT
bool connectionIsLoading(AsyncSnapshot<dynamic> snapshot){

  if (snapshot.connectionState == ConnectionState.waiting){
    return true;
  }
  else {
    return false;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
bool stringIsEmpty(String string) {

  if (string == null || string == '' || string.isEmpty == true

// ||
// TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
// ||
// TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

  ) {
    return true;
  }

  else {
    return false;
  }

}
// -----------------------------------------------------------------------------
