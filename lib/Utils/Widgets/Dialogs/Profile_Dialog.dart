// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Screens/ViewProfileScreen.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:me_chat/models/ChatUserModel.dart';

class ProfileDialog extends StatelessWidget {
  ProfileDialog({super.key, required this.user});

  final ChatUser user;
  var image = 150.0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: radius(20)),
      content: SizedBox(
        height: DP.height(.3),
        width: DP.dWidth(6),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Margine(
                margin: const EdgeInsets.only(top: 55, bottom: 20),
                child: ClipRRect(
                  borderRadius: radius(image),
                  child: SizedBox(
                      height: image,
                      width: image,
                      child: NetworkImages(url: user.image)),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CP(
                    v: 12,
                    h: 16,
                    child: SizedBox(
                      width: 180,
                      child: TextFW400(
                          text: user.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontSize: 18),
                    )),
                IconButtons(
                  onTap: () {
                    Nav.pop();
                    Nav.pushMaterial(ViewProfileScreen(user: user));
                  },
                  icon: Icon(
                    Icons.info,
                    color: appColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
