import 'package:flutter/material.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Packages/CustomeTexts.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/MyDateUtils.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';

import '../Packages/Package_Export.dart';
import '../models/MessageModel.dart';

class MessageCard extends StatelessWidget {
  MessageCard({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == message.fromId;
    return isMe ? _green() : _white();
  }

  Widget _green() {
    return Margine(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: message.type == Type.text
                          ? const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)
                          : const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                      margin: const EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: appColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: message.type == Type.text
                          ? TextFW400(
                              text: message.msg,
                              fontSize: 16,
                              textcolor: white,
                            )
                          : ClipRRect(
                              // decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              // ),
                              child: NetworkImagesChat(url: message.msg)),
                    ),
                    sizeH(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFW400(
                          text:
                              MyDateUtils.getFormattedTime(time: message.sent),
                          fontSize: 12,
                          textcolor: textFeildColor,
                        ),
                        sizeW(5),
                        if (message.read.isNotEmpty)
                          const Icon(
                            Icons.done_all,
                            size: 18,
                            color: Colors.blue,
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _white() {
    if (message.read.isEmpty) {
      APIs.updateMessageReadStatus(message);
    }
    return Margine(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: message.type == Type.text
                          ? const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)
                          : const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                      margin: const EdgeInsets.only(right: 30),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        border: message.type == Type.text
                            ? Border.all(color: appColor, width: 2)
                            : null,
                      ),
                      child: message.type == Type.text
                          ? TextFW400(
                              text: message.msg,
                              fontSize: 16,
                              textcolor: appColor,
                            )
                          : ClipRRect(
                              // decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              // ),
                              child: NetworkImagesChat(url: message.msg)),
                    ),
                    sizeH(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFW400(
                          text:
                              MyDateUtils.getFormattedTime(time: message.sent),
                          fontSize: 12,
                          textcolor: textFeildColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
