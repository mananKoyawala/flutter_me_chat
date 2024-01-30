// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import '../Packages/Package_Export.dart';

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({
    Key? key,
    required this.onImage,
    required this.onCamera,
  }) : super(key: key);

  final VoidCallback onImage;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: white, borderRadius: radius(30)),
      height: 230,
      width: DP.infinity(),
      // alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizeH(30),
          TextFW600(
              text: "Pick Profile Picture", fontSize: 22, textcolor: black),
          sizeH25(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageWidget(
                onTap: onImage,
                image: 'assets/icons/image.png',
              ),
              ImageWidget(
                onTap: onCamera,
                image: 'assets/icons/camera.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.onTap,
    required this.image,
  });

  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(3, 3),
          color: Colors.grey.shade400,
          blurRadius: 2,
        ),
        BoxShadow(
          offset: const Offset(-3, 3),
          color: Colors.grey.shade400,
          blurRadius: 2,
        )
      ], borderRadius: radius(100)),
      child: ClickEffect(
        onTap: onTap,
        borderRadius: radius(100),
        child: Container(
          height: 100,
          width: 100,
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: radius(100)),
          child: Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 60,
            ),
          ),
        ),
      ),
    );
  }
}
