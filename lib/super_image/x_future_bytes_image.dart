import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:super_image/helpers/helpers.dart';

import '../super_image.dart';

class FutureImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FutureImage({
    @required this.snapshot,
    @required this.width,
    @required this.height,
    @required this.boxFit,
    @required this.errorBuilder,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AsyncSnapshot<Uint8List> snapshot;
  final double width;
  final double height;
  final BoxFit boxFit;
  final Function(BuildContext, Object, StackTrace) errorBuilder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (connectionIsLoading(snapshot) == true){
      return InfiniteLoadingBox(
        width: width,
        height: height,
      );
    }

    /// UI.IMAGE
    else {

      return CachelessImage(
        bytes: snapshot.data,
        boxFit: boxFit,
        width: width,
        height: height,
        // errorBuilder: errorBuilder,
        // scale: 1,
      );
    }

  }
/// --------------------------------------------------------------------------
}
