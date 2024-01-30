import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Controller/ChatController.dart';
import 'package:me_chat/Packages/CustomeTexts.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/MyDateUtils.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:gallery_saver_updated/gallery_saver.dart ';
import '../Packages/Package_Export.dart';
import '../models/MessageModel.dart';
import 'package:get/get.dart';

ChatController ctr = Get.find<ChatController>();

class MessageCard extends StatelessWidget {
  MessageCard({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == message.fromId;
    return InkWell(
        onLongPress: () {
          viewSheet(isMe);
        },
        child: isMe ? _green() : _white());
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
                        message.read.isNotEmpty
                            ? const Icon(
                                Icons.done_all,
                                size: 18,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.done,
                                size: 18,
                                color: textFeildColor,
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
                                topRight: Radius.circular(20),
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

  viewSheet(bool isMe) {
    showBottomSheets(CP(
      h: 16,
      v: 16,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 5,
            margin: EdgeInsets.symmetric(horizontal: DP.dWidth(3), vertical: 0),
            decoration: BoxDecoration(
                color: Colors.grey.shade500, borderRadius: radius(10)),
          ),
          sizeH(30),

          // Copy Item
          message.type == Type.text
              ? OptionItem(
                  icon: Icons.copy,
                  title: "Copy Text",
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: message.msg))
                        .then((value) => Nav.pop());
                  })
              : OptionItem(
                  icon: Icons.download,
                  title: "Save Image",
                  onTap: () {
                    saveTheImage(message);
                  }),

          if (isMe) const Div(),

          // Edit Item
          if (message.type == Type.text && isMe)
            OptionItem(
                icon: Icons.edit,
                title: "Edit Message",
                onTap: () {
                  Nav.pop();
                  showMessageUpdateDialog(message);
                }),
          // Delete Item
          if (isMe)
            OptionItem(
                icon: Icons.delete,
                title: message.type == Type.text
                    ? "Delete Message"
                    : "Delete Image",
                onTap: () {
                  Nav.pop();
                  APIs.deleteMessage(message).then((value) {
                    toast("Message Deleted");
                  });
                },
                color: Colors.red),
          const Div(),
          // Sent Time
          OptionItem(
              icon: Icons.remove_red_eye,
              title:
                  "Sent At ${MyDateUtils.getMessageTime(time: message.sent)}",
              onTap: () {},
              color: Colors.blue),
          // Read Time
          OptionItem(
              icon: Icons.remove_red_eye,
              title: message.read.isNotEmpty
                  ? "Read At ${MyDateUtils.getMessageTime(time: message.read)}"
                  : "Not Seen Yet",
              onTap: () {},
              color: appColor),
          sizeH10(),
        ],
      ),
    ));
  }

  saveTheImage(Message msg) async {
    try {
      Nav.pop();
      await GallerySaver.saveImage(msg.msg, albumName: 'Me Chat')
          .then((success) {
        if (success != null && success) {
          toast('Image Saved!');
        }
      });
    } catch (e) {
      Nav.pop();
      toast('Error in Saveing Image');
    }
  }
}

showMessageUpdateDialog(Message message) {
  ctr.changeChatEditingController(message.msg);
  showDialog(
      context: ncontext,
      builder: (_) {
        return AlertDialog(
          surfaceTintColor: white,
          backgroundColor: white,
          shape: RoundedRectangleBorder(borderRadius: radius(20)),
          title: Row(
            children: [
              Icon(Icons.message, color: appColor),
              sizeW(15),
              TextFW400(text: 'Update Message', fontSize: 18, textcolor: black)
            ],
          ),
          content: Form(
            key: ctr.formKey,
            child: TheTextFeild(
              funValidate: (val) {
                if (val != null && val.isEmpty) {
                  return "Please write something 😊";
                }
                return null;
              },
              isborder: true,
              borderRadius: 10,
              hintStyle: TextStyle(color: textFeildColor),
              fieldColor: Colors.grey.shade400,
              controller: ctr.chatEditCtr,
              onClickColor: appColor,
              borderWidth: 1.5,
              hintText: "Your message here...",
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWithSimpleText(
                  onTap: () {
                    Nav.pop();
                  },
                  title: TextFW400(
                      text: 'Cancel', fontSize: 16, textcolor: appColor),
                  width: 100,
                  backgroundColor: white,
                ),
                ButtonWithSimpleText(
                  onTap: () {
                    if (ctr.formKey.currentState!.validate()) {
                      Nav.pop();
                      APIs.editMessage(message, ctr.chatEditCtr.text);
                    }
                  },
                  title:
                      TextFW400(text: 'Update', fontSize: 16, textcolor: white),
                  width: 100,
                  backgroundColor: appColor,
                ),
              ],
            )
          ],
        );
      });
}

class Div extends StatelessWidget {
  const Div({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizeH(5),
        const Divider(color: Colors.black26),
        sizeH(5),
      ],
    );
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ClickEffect(
      onTap: onTap,
      borderRadius: radius(0),
      child: CP(
        v: 15,
        child: Row(
          children: [
            Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                child: Icon(icon, color: color ?? appColor)),
            sizeW(15),
            Flexible(
                child: TextFW400(
              text: title,
              fontSize: 16,
              textcolor: Colors.black54,
              letterSpacing: 0.5,
            ))
          ],
        ),
      ),
    );
  }
}
