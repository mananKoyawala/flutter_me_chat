import 'package:me_chat/Packages/Package_Export.dart';

class ButtonWithSuffixIcon extends StatelessWidget {
  const ButtonWithSuffixIcon({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.suffixIcon,
    this.title,
    required this.onTap,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onTap,
      borderRadius: radius(borderRadius ?? 25),
      child: Container(
        height: height ?? 50,
        width: width ?? 160,
        decoration: BoxDecoration(
          color: backgroundColor ?? black,
          borderRadius: radius(borderRadius ?? 25),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title ??
                TextFW500(
                  text: 'Add to Cart',
                  fontSize: 16,
                  textColor: white,
                ),
            sizeW10(),
            suffixIcon ?? const StaticIcon(),
          ],
        ),
      ),
    );
  }
}
