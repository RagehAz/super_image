part of super_image;

class SuperImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImage({
    @required this.width,
    @required this.height,
    @required this.pic,
    this.fit = BoxFit.cover,
    this.scale = 1,
    this.iconColor,
    this.loading = false,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    this.package,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double width;
  final double height;
  final BoxFit fit;
  final double scale;
  final Color iconColor;
  final bool loading;
  final Color backgroundColor;
  final dynamic corners;
  final bool greyscale;
  final String package;
  /// --------------------------------------------------------------------------
  static DecorationImage decorationImage({
    @required String picture,
    BoxFit boxFit
  }) {
    DecorationImage _image;

    if (picture != null && picture != '') {
      _image = DecorationImage(
        image: AssetImage(picture),
        fit: boxFit ?? BoxFit.cover,
      );
    }

    return picture == '' ? null : _image;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperImageBox(
      width: width,
      height: height,
      boxFit: fit,
      scale: scale,
      backgroundColor: backgroundColor,
      borderRadius: corners,
      greyscale: greyscale,
      child: ImageSwitcher(
        width: width,
        height: height,
        pic: pic,
        boxFit: fit,
        scale: scale,
        iconColor: iconColor,
        loading: loading,
        backgroundColor: backgroundColor,
        package: package,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
