// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Controller/API/Apis.dart';

import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/MyDateUtils.dart';
import 'package:me_chat/Utils/Widgets/Dialogs/Profile_Dialog.dart';
import 'package:me_chat/models/MessageModel.dart';

import '../../models/ChatUserModel.dart';
import '../Services/NavigatorServices.dart';
import 'Network_Image.dart';

class ChatUserCard extends StatelessWidget {
  ChatUserCard({
    Key? key,
    required this.isLast,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  final bool isLast;
  final ChatUser user;
  var imageHeight = 55.0;
  final VoidCallback onTap;

  Message? message;

  Future<dynamic> showProfile() {
    return showDialog(
        context: ncontext, builder: (ctx) => ProfileDialog(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return Margine(
      margin: const EdgeInsets.only(bottom: 5),
      child: ClickEffect(
        onTap: onTap,
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
          child: StreamBuilder(
              stream: APIs.getLastMessage(user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                if (list.isNotEmpty) {
                  message = list[0];
                }
                return Row(
                  children: [
                    ClickEffect(
                      onTap: () {
                        showProfile();
                      },
                      borderRadius: radius(imageHeight),
                      child: ClipRRect(
                        borderRadius: radius(imageHeight),
                        child: Container(
                            decoration: BoxDecoration(
                                color: imageBg,
                                borderRadius: radius(imageHeight)),
                            height: imageHeight,
                            width: imageHeight,
                            child: NetworkImages(url: user.image)),
                      ),
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          sizeH(5),
                          ShowLastMessage(message: message, user: user),
                        ],
                      ),
                    ),
                    sizeW(15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: message == null
                          ? const SizedBox()
                          : message!.read.isEmpty && (message!.toId != user.id)
                              //if message.toId is not work use fromId
                              ? Margine(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: appColor,
                                  ),
                                )
                              : TextFW400(
                                  text: message != null
                                      ? MyDateUtils.getLastMessageTime(
                                          time: message!.sent, showYear: false)
                                      : '',
                                  fontSize: 14,
                                  textcolor:
                                      const Color.fromARGB(255, 163, 163, 163),
                                ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class ShowLastMessage extends StatelessWidget {
  ShowLastMessage({super.key, this.message, required this.user});

  Message? message;
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      if (message!.type == Type.text) {
        return TextFW400(
          text: message!.msg,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textcolor: textFeildColor,
        );
      }
      if (message!.type == Type.image) {
        return Icon(
          Icons.image,
          size: 18,
          color: textFeildColor,
        );
      }
    }
    return TextFW400(
      text: user.about,
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textcolor: textFeildColor,
    );
  }
}
