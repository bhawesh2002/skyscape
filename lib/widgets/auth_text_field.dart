import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextFieldOne extends StatelessWidget {
  final IconData icon;
  final Color? bgColor;
  final Color? iconColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Color? iconBoxColor;
  final TextStyle? style;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final String? errorText;
  const AuthTextFieldOne({
    super.key,
    required this.icon,
    this.bgColor,
    this.iconColor,
    this.border,
    this.borderRadius,
    this.controller,
    this.cursorColor,
    this.style,
    this.obscureText,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.iconBoxColor,
    this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.07,
      child: LayoutBuilder(
        builder: ((context, constraints) {
          return Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.17,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color: iconBoxColor,
                  borderRadius: borderRadius,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: constraints.maxWidth * 0.06,
                  weight: 700,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.015,
              ),
              Expanded(
                child: Container(
                  height: Get.height * 0.07,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: border,
                      borderRadius: borderRadius,
                      color: bgColor ?? Colors.white),
                  child: TextFormField(
                    onChanged: onChanged,
                    onTap: onTap,
                    controller: controller,
                    cursorColor: cursorColor ?? Colors.white,
                    style: style ??
                        GoogleFonts.montserrat(
                            color: iconBoxColor ?? Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: constraints.maxWidth * 0.038),
                    obscureText: obscureText ?? false,
                    decoration: InputDecoration(
                      errorText: errorText,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: iconBoxColor ?? Colors.white,
                      hintText: hintText ?? "",
                      hintStyle: hintStyle ??
                          GoogleFonts.montserrat(
                            color:
                                iconBoxColor ?? Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class AuthTextFieldTwo extends StatelessWidget {
  final IconData icon;
  final Color? bgColor;
  final Color? iconColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Color? iconBoxColor;
  final TextStyle? style;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final String? errorText;
  final String? Function(String?)? validator;
  const AuthTextFieldTwo({
    super.key,
    required this.icon,
    this.bgColor,
    this.iconColor,
    this.border,
    this.borderRadius,
    this.controller,
    this.cursorColor,
    this.style,
    this.obscureText,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.iconBoxColor,
    this.onTap,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.07,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: border ?? Border.all(width: 2, color: Get.theme.primaryColor),
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          color: bgColor ?? Colors.white),
      child: LayoutBuilder(
        builder: ((context, constraints) {
          return Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.18,
                decoration: BoxDecoration(
                  color: iconBoxColor ?? Get.theme.primaryColor,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      right: (constraints.maxWidth * 0.18 +
                              (constraints.maxWidth * 0.01)) /
                          (constraints.maxWidth * 0.18 +
                              (constraints.maxWidth * 0.01)),
                      child: Icon(
                        icon,
                        color: iconColor ?? Colors.white,
                        size: constraints.maxWidth * 0.06,
                        weight: 700,
                      ),
                    ),
                    //seperation
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.white,
                          width: constraints.maxWidth * 0.01,
                          height: constraints.maxHeight,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: TextFormField(
                    onChanged: onChanged,
                    onTap: onTap,
                    validator: validator,
                    controller: controller,
                    cursorColor: cursorColor ?? Get.theme.primaryColor,
                    style: style ??
                        GoogleFonts.montserrat(
                            color: iconBoxColor ?? Get.theme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: constraints.maxWidth * 0.038),
                    obscureText: obscureText ?? false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      fillColor: iconBoxColor ?? Get.theme.primaryColor,
                      hintText: hintText ?? "",
                      errorText: errorText,
                      hintStyle: hintStyle ??
                          GoogleFonts.montserrat(
                            color: iconBoxColor ??
                                Get.theme.primaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
