import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Packages/RippleEffectContainer.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({
    super.key,
    required this.onTap,
    this.height,
    this.icon,
    this.radiu,
  });
  final VoidCallback onTap;
  final double? height;
  final Widget? icon;
  final double? radiu;

  @override
  Widget build(BuildContext context) {
    return ClickEffect(
        onTap: onTap,
        borderRadius: radius(radiu ?? 30),
        child: SizedBox(
            height: height ?? 50,
            width: height ?? 50,
            child: icon ?? const Icon(Icons.settings)));
  }
}
