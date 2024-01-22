// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Constants.dart';

import '../../models/ChatUserModel.dart';
import 'Network_Image.dart';

class ChatUserCard extends StatelessWidget {
  ChatUserCard({
    Key? key,
    required this.isLast,
    required this.user,
  }) : super(key: key);

  final bool isLast;
  final ChatUser user;
  var imageHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    return Margine(
      margin: const EdgeInsets.only(bottom: 5),
      child: ClickEffect(
        onTap: () {},
        borderRadius: radius(0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 5, left: 16, right: 16),
          decoration: BoxDecoration(
              color: white,
              border: isLast
                  ? const Border()
                  : Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade300, width: 1))),
          width: DP.infinity(),
          height: 85,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: radius(imageHeight),
                child: Container(
                    decoration: BoxDecoration(
                        color: imageBg, borderRadius: radius(imageHeight)),
                    height: imageHeight,
                    width: imageHeight,
                    child: NetworkImages(url: user.image)),
              ),
              sizeW(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFW400(
                      text: user.name,
                      fontSize: 16,
                      textcolor: black,
                    ),
                    sizeH(5),
                    TextFW400(
                      text: user.about,
                      fontSize: 14,
                      textcolor: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
              sizeW10(),
              const Align(
                alignment: Alignment.centerRight,
                child: TextFW400(
                  text: '12:00 PM',
                  fontSize: 14,
                  textcolor: Color.fromARGB(255, 163, 163, 163),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
