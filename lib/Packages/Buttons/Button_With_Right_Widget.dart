import 'package:me_chat/Packages/Package_Export.dart';

import '../RippleEffectContainer.dart';

class ButtonWithRightIcon extends StatelessWidget {
  const ButtonWithRightIcon({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.title,
    this.suffixWidget,
    required this.onTap,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? title;
  final Widget? suffixWidget;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onTap,
      borderRadius: radius(borderRadius ?? 10),
      child: Container(
        height: height ?? 50,
        width: width ?? DP.infinity(context),
        decoration: BoxDecoration(
          color: backgroundColor ?? black,
          borderRadius: radius(borderRadius ?? 10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CP(
              h: 16,
              child: title ??
                  TextFW700(
                    text: 'Proceed to checkout',
                    fontSize: 18,
                    textcolor: white,
                  ),
            ),
            CP(
              h: 10,
              child: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: radius(10),
                  color: white,
                ),
                child: suffixWidget ?? const StaticIcon(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
