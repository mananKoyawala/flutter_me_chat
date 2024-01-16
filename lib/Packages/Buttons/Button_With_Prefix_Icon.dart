import 'package:me_chat/Packages/Package_Export.dart';

class ButtonWithPrefixIcon extends StatelessWidget {
  const ButtonWithPrefixIcon({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.prefixIcon,
    this.title,
    required this.onTap,
    this.extraSpaceInBetween,
    this.specialText,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? prefixIcon;
  final Widget? title;
  final Widget? specialText;
  final VoidCallback onTap;
  final double? extraSpaceInBetween;

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
            prefixIcon ?? const StaticIcon(),
            extraSpaceInBetween == null
                ? sizeW10()
                : sizeW(extraSpaceInBetween!),
            title ??
                TextFW500(
                  text: 'Add to Cart',
                  fontSize: 16,
                  textColor: white,
                ),
            specialText ?? const Text('')
          ],
        ),
      ),
    );
  }
}
