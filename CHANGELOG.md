## 0.0.5
* fixed url trim bug

## 0.0.1

* Super Image
  * is a smart widget that works with several object types

Supported Object types
* null : shows SizedBox()
* loading : shows InfiniteLoadingBox()
* absoluteURL : shows Image.network()
* JPG local asset : shows Image.asset()
* SVG local asset : shows WebsafeSVG.asset()
* File : shows Image.file()
* Uint8List : shows CachelessImage()
* base64 : shows CachelessImage()
* ui.Image : shows RawImage()
* img.Image : shows CachelessImage()
* otherwise : shows dvGouran Icon
