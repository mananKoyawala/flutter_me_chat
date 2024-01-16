import 'package:me_chat/Packages/Package_Export.dart';

class ButtonWithSimpleText extends StatelessWidget {
  const ButtonWithSimpleText({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.title,
    required this.onTap,
    this.border,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? title;
  final VoidCallback onTap;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onTap,
      borderRadius: radius(borderRadius ?? 10),
      child: Container(
        height: height ?? 50,
        width: width ?? DP.infinity(),
        decoration: BoxDecoration(
            color: backgroundColor ?? black,
            borderRadius: radius(borderRadius ?? 10),
            border: border),
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
          ],
        ),
      ),
    );
  }
}
