// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Constants.dart';
import 'package:me_chat/Packages/CustomeTexts.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/AppBaar.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/MyDateUtils.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:me_chat/models/ChatUserModel.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key, required this.user});

  final ChatUser user;
  var image = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CP(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                title: user.name,
                text: SizedBox(
                  width: DP.width(.25),
                  child: TextFW400(
                      text: user.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      fontSize: 22),
                ),
              ),
              sizeH10(),
              CP(
                h: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: radius(image),
                      child: Container(
                        height: image,
                        width: image,
                        decoration: BoxDecoration(
                            color: imageBg, borderRadius: radius(image)),
                        child: NetworkImagesChat(url: user.image),
                      ),
                    ),
                    sizeH(30),
                    FittedBox(
                      child: TextFW400(
                        text: user.email,
                        fontSize: 16,
                        textcolor: black,
                      ),
                    ),
                    sizeH(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextFW600(
                          text: 'About : ',
                          fontSize: 16,
                          textcolor: Colors.black87,
                        ),
                        TextFW400(
                          text: user.about,
                          fontSize: 16,
                          textcolor: textFeildColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              CP(
                h: 16,
                v: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextFW600(
                      text: 'Joined on : ',
                      fontSize: 16,
                      textcolor: Colors.black87,
                    ),
                    TextFW400(
                      text: MyDateUtils.getLastMessageTime(
                          time: user.createdAt, showYear: true),
                      fontSize: 16,
                      textcolor: textFeildColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
