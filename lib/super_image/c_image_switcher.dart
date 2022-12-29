// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:typed_data';

import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_image/helpers/helpers.dart';
import 'package:super_image/helpers/ui_checker.dart';
import 'package:super_image/super_image/x_cacheless_image.dart';
import 'package:super_image/super_image/x_infinity_loading_box.dart';
import 'package:super_image/super_image/x_local_asset_checker.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

class ImageSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageSwitcher({
    @required this.width,
    @required this.height,
    @required this.pic,
    @required this.boxFit,
    @required this.scale,
    @required this.iconColor,
    @required this.loading,
    @required this.backgroundColor,
    @required this.package,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double width;
  final double height;
  final BoxFit boxFit;
  final double scale;
  final Color iconColor;
  final bool loading;
  final Color backgroundColor;
  final String package;
  // -----------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _errorBuilder (BuildContext ctx, Object error, StackTrace stackTrace) {
    // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: Colorz.white10,
      // child: const SuperVerse(
      //   verse: Verse(
      //     text: 'phid_error',
      //     translate: true,
      //     casing: Casing.lowerCase,
      //   ),
      //   size: 0,
      //   maxLines: 2,
      // ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _loadingBuilder(BuildContext context , Widget child, ImageChunkEvent imageChunkEvent){

    // blog('SUPER IMAGE LOADING BUILDER : imageChunkEvent.cumulativeBytesLoaded : ${imageChunkEvent?.cumulativeBytesLoaded} / ${imageChunkEvent?.expectedTotalBytes}');

    /// AFTER LOADED
    if (imageChunkEvent == null){
      return child;
    }
    /// WHILE LOADING
    else {

      final double _percentage = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes;

      return Container(
        width: width,
        height: height,
        color: Colorz.white50,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: width,
          height: height * _percentage,
          color: backgroundColor ?? Colorz.white20,
        ),
      );
    }

  }
  // --------------------
  ///DEPRECATED
  /*
  Widget _futureBytesBuilder (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot){

    return FutureImage(
      snapshot: snapshot,
      width: width,
      height: height,
      boxFit: boxFit,
      errorBuilder: _errorBuilder,
    );

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NULL
    if (pic == null){

      // blog('pic is null');

      return SizedBox(
        width: width,
        height: height,
        // color: Colorz.errorColor,
      );

    }

    /// LOADING
    else if (loading == true){

      return InfiniteLoadingBox(
        width: width,
        height: height,
        color: backgroundColor,
      );
    }

    /// URL
    else if (isAbsoluteURL(pic) == true){

      return Image.network(
        pic,
        key: const ValueKey<String>('SuperImage_url'),
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: _errorBuilder,
        gaplessPlayback: _gaplessPlayback,
        loadingBuilder: _loadingBuilder,
      );
    }

    /// JPG OR PNG
    else if (objectIsJPGorPNG(pic) == true){

      return Image.asset(
        pic,
        key: const ValueKey<String>('SuperImage_png_or_jpg'),
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: _errorBuilder,
        scale: 1,
        gaplessPlayback: _gaplessPlayback,
        package: package,
      );

    }

    /// SVG
    else if (objectIsSVG(pic) == true){

      return WebsafeSvg.asset(
          pic,
          fit: boxFit,
          color: iconColor,
          width: width,
          height: height,
          package: package
      );
    }

    /// FILE
    else if (objectIsFile(pic) == true){

      return Image.file(
        pic,
        key: const ValueKey<String>('SuperImage_file'),
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: _errorBuilder,
        gaplessPlayback: _gaplessPlayback,
      );
    }

    // /// PATH
    // else if (ObjectCheck.objectIsPicPath(pic) == true){
    //
    //   // return Container(
    //   //   width: width,
    //   //   height: height,
    //   //   color: Colorz.red50,
    //   // );
    //
    //   return FutureBuilder(
    //     future: PicProtocols.fetchPicUiImage(pic),
    //     builder: (_, AsyncSnapshot<ui.Image> snap){
    //
    //       return RawImage(
    //         /// MAIN
    //         key: const ValueKey<String>('SuperImage_UIIMAGE'),
    //         // debugImageLabel: ,
    //
    //         /// IMAGE
    //         image: snap?.data,
    //         // repeat: ImageRepeat.noRepeat, // DEFAULT
    //
    //         /// SIZES
    //         width: width,
    //         height: height,
    //         scale: scale,
    //
    //         /// COLORS
    //         // color: widget.color,
    //         // opacity: opacity,
    //         // colorBlendMode: blendMode,
    //         // filterQuality: FilterQuality.low, // DEFAULT
    //         // invertColors: false, // DEFAULT
    //
    //         /// POSITIONING
    //         // alignment: Alignment.center, // DEFAULT
    //         fit: boxFit,
    //
    //         /// DUNNO
    //         // centerSlice: ,
    //         // isAntiAlias: ,
    //         // matchTextDirection: false, // DEFAULT : flips image horizontally
    //       );
    //
    //
    //       // return CachelessImage(
    //       //   key: const ValueKey<String>('SuperImage_future_bytes'),
    //       //   bytes: snap?.data?.bytes,
    //       //   width: width,
    //       //   height: height,
    //       //   color: backgroundColor,
    //       //   boxFit: boxFit,
    //       // );
    //
    //     },
    //   );
    // }

    // /// PIC MODEL
    // else if (pic is PicModel){
    //
    //
    //   final PicModel _picModel = pic;
    //
    //   return CachelessImage(
    //     key: const ValueKey<String>('SuperImage_pic_model'),
    //     bytes: _picModel.bytes,
    //     width: width,
    //     height: height,
    //     color: backgroundColor,
    //     boxFit: boxFit,
    //   );
    // }

    /// UINT8LIST
    else if (objectIsUint8List(pic) == true){

      return CachelessImage(
        key: const ValueKey<String>('SuperImage_bytes'),
        bytes: pic,
        width: width,
        height: height,
        color: backgroundColor,
        boxFit: boxFit,
      );
    }

    /// BASE64
    else if (isBase64(pic) == true){

      return CachelessImage(
        key: const ValueKey<String>('SuperImage_base64'),
        bytes: base64Decode(pic),
        width: width,
        height: height,
        color: backgroundColor,
        boxFit: boxFit,
      );
    }

    /// UI.IMAGE
    else if (objectIsUiImage(pic) == true){

      final ui.Image _uiImage = pic;

      return RawImage(
        /// MAIN
        key: const ValueKey<String>('SuperImage_UIIMAGE'),
        // debugImageLabel: ,

        /// IMAGE
        image: _uiImage,
        // repeat: ImageRepeat.noRepeat, // DEFAULT

        /// SIZES
        width: width,
        height: height,
        scale: scale,

        /// COLORS
        // color: widget.color,
        // opacity: opacity,
        // colorBlendMode: blendMode,
        // filterQuality: FilterQuality.low, // DEFAULT
        // invertColors: false, // DEFAULT

        /// POSITIONING
        // alignment: Alignment.center, // DEFAULT
        fit: boxFit,

        /// DUNNO
        // centerSlice: ,
        // isAntiAlias: ,
        // matchTextDirection: false, // DEFAULT : flips image horizontally
      );
    }

    /// IMG.IMAGE
    else if (objectIsImgImage(pic) == true){

      final Uint8List _bytes = img.encodeJpg(pic, quality: 100);

      return CachelessImage(
        key: const ValueKey<String>('SuperImage_imgImage'),
        bytes: _bytes,
        width: width,
        height: height,
        color: backgroundColor,
        boxFit: boxFit,
      );
    }

    /// NEITHER ANY OF ABOVE
    else {
      return Image.asset(
        Iconz.dvGouran,
        key: const ValueKey<String>('SuperImage_other'),
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: _errorBuilder,
        scale: 1,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
