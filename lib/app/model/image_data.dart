import 'dart:ui';

class ImageData {
  String? image;
  double? imagePosX;
  double? imagePosY;
  double? imageAngle;
  Color? imageColor;
  double? imageScale;

  ImageData copyWith({
    String? image,
    double? imagePosX,
    double? imageScale,
    double? imagePosY,
    double? imageAngle,
    Color? imageColor,
  }) {
    return ImageData(
      image: image ?? this.image,
      imagePosX: imagePosX ?? this.imagePosX,
      imagePosY: imagePosY ?? this.imagePosY,
      imageAngle: imageAngle ?? this.imageAngle,
      imageColor: imageColor ?? this.imageColor,
        imageScale:imageScale??this.imageScale
    );
  }

  ImageData({
    this.image,
    this.imagePosX,
    this.imagePosY,
    this.imageAngle,
    this.imageColor,
    this.imageScale
  });
}
