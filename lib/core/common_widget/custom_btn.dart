import 'package:flutter/material.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final dynamic btnStyle;
  final bool unsetWidth;
  final bool unsetHeight;
  final Widget? icon;
  final double? radius;
  final Alignment? alignment;

  const CustomBtn({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.style,
    this.btnStyle,
    this.unsetHeight = false,
    this.unsetWidth = false,
    this.icon,
    this.radius,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: unsetWidth ? null : width ?? MediaQuery.of(context).size.width,
      height: unsetHeight ? null : height ?? 55,
      child: icon != null
          ? ElevatedButton.icon(
              icon: icon!,
              onPressed: onTap,
              style: btnStyle ??
                  ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor ?? ColorName.primary,
                    shape: RoundedRectangleBorder(
                        // border radius
                        borderRadius: BorderRadius.circular(radius ?? 15)),
                  ),
              label: CustomText(
                text: label,
                style:
                    style ?? const TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: btnStyle ??
                  ElevatedButton.styleFrom(
                    alignment: alignment ?? Alignment.center,
                    backgroundColor: backgroundColor ?? ColorName.primary,
                    shape: RoundedRectangleBorder(
                        // border radius
                        borderRadius: BorderRadius.circular(radius ?? 15)),
                  ),
              child: CustomText(
                text: label,
                style:
                    style ?? const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
    );
  }
}
