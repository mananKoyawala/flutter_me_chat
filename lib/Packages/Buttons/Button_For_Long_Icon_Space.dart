import 'package:me_chat/Packages/Package_Export.dart';

class ButtonWithLongIcons extends StatelessWidget {
  const ButtonWithLongIcons({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.title,
    required this.prefixIcon,
    required this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    required this.onTap,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? title;
  final bool prefixIcon;
  final bool suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final VoidCallback onTap;

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
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prefixIcon
                ? prefixWidget ?? const StaticIcon()
                : CP(
                    h: 16,
                    child: Icon(Icons.home, color: backgroundColor ?? black)),
            title ??
                TextFW500(
                  text: 'Add to Cart',
                  fontSize: 16,
                  textColor: white,
                ),
            suffixIcon
                ? suffixWidget ??
                    const CP(h: 16, child: Icon(Icons.home, color: Colors.red))
                : CP(
                    h: 16,
                    child: Icon(Icons.home, color: backgroundColor ?? black)),
          ],
        ),
      ),
    );
  }
}

class StaticIcon extends StatelessWidget {
  const StaticIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.settings);
  }
}
