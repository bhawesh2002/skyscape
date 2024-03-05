import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlternativeAuthOptiion extends StatelessWidget {
  final String image;
  final Text authOption;
  final double? imageSize;
  final double? gap;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final VoidCallback onTap;
  const AlternativeAuthOptiion({
    super.key,
    required this.image,
    required this.authOption,
    this.imageSize,
    this.gap,
    this.width,
    this.height,
    this.decoration,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: width,
          height: height,
          decoration: decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: imageSize ?? Get.height * 0.05,
                width: imageSize ?? Get.height * 0.05,
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: gap ?? Get.width * 0.02)),
              authOption,
            ],
          ),
        ),
      ),
    );
  }
}
