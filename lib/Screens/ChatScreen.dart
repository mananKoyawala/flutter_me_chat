// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:me_chat/Controller/ChatController.dart';
import 'package:me_chat/Screens/ViewProfileScreen.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/Message_Card.dart';
import 'package:me_chat/Utils/MyDateUtils.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import 'package:me_chat/models/MessageModel.dart';
import 'package:get/get.dart';
import '../Controller/API/Apis.dart';
import '../Packages/Package_Export.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final ChatUser user;
  List<Message> list = [];
  ChatController ctr = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (ctr.showEmoji.value == true) {
          ctr.showEmoji.value = false;
        }
        ctr.chatTextCtr.clear();
        return Future.value(true);
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            unfocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                ClickEffect(
                  onTap: () {
                    Nav.pushMaterial(ViewProfileScreen(user: user));
                  },
                  borderRadius: radius(0),
                  child: Column(
                    children: [
                      sizeH(10),
                      TopBar(user: user),
                      Container(
                        height: 10,
                        width: DP.infinity(),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: textFeildColor, width: 1.5)),
                        ),
                      ),
                    ],
                  ),
                ),
                sizeH(20),
                Expanded(
                    child: Container(
                  // color: const Color.fromARGB(138, 188, 252, 191),
                  color: white,
                  child: CP(
                    h: 16,
                    child: StreamBuilder(
                        stream: APIs.getAllMessages(user),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const SizedBox();
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data!.docs;
                              list = data
                                  .map((e) => Message.fromJson(e.data()))
                                  .toList();

                              if (list.isEmpty) {
                                return Center(
                                  child: TextFW400(
                                    text: "Say Hii! 👋",
                                    fontSize: 20,
                                    textcolor: black,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    reverse: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return MessageCard(
                                        message: list[index],
                                      );
                                    });
                              }
                          }
                        }),
                  ),
                )),
                Obx(() => ctr.isUploading.value
                    ? Margine(
                        margin:
                            const EdgeInsets.only(top: 2, bottom: 2, right: 16),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircularProgressIndicator(
                              color: appColor,
                              strokeWidth: 2,
                            )))
                    : const SizedBox()),
                BottomContainer(
                  controller: ctr.chatTextCtr,
                  user: user,
                  ctr: ctr,
                ),
                Obx(
                  () => ctr.showEmoji.value
                      ? SizedBox(
                          height: DP.dHeight(3),
                          child: EmojiPicker(
                            textEditingController: ctr.chatTextCtr,
                            config: Config(
                              // iconColor: ,

                              iconColorSelected: appColor,
                              indicatorColor: appColor,
                              backspaceColor: appColor,

                              columns: 7,
                              emojiSizeMax: 28 *
                                  (Platform.isIOS
                                      ? 1.0
                                      : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                            ),
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.controller,
    required this.user,
    required this.ctr,
  });
  final TextEditingController controller;
  final ChatUser user;
  final ChatController ctr;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromARGB(138, 188, 252, 191),
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: radius(10),
                  border: Border.all(color: appColor)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButtons(
                    onTap: () {
                      unfocus();
                      ctr.changeShowEmoji();
                    },
                    icon: Icon(
                      Icons.tag_faces_rounded,
                      color: appColor,
                      size: 28,
                    ),
                  ),
                  Expanded(
                    child: TheTextFeild(
                        maxLines: null,
                        funValidate: (val) {
                          return null;
                        },
                        onTap: () {
                          if (ctr.showEmoji.value == true) {
                            ctr.showEmoji.value = false;
                          }
                        },
                        controller: controller,
                        onClickColor: transparent,
                        fieldColor: transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2),
                        cursorColor: appColor,
                        hintText: "Type Something...",
                        hintStyle: TextStyle(color: appColor),
                        isborder: true),
                  ),
                  IconButtons(
                    onTap: () {
                      ctr.pickGalleryImage(user);
                    },
                    icon: Icon(
                      Icons.image,
                      color: appColor,
                      size: 28,
                    ),
                  ),
                  IconButtons(
                    onTap: () {
                      ctr.pickCameraImage(user);
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: appColor,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          sizeW10(),
          Margine(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ClickEffect(
              onTap: () {
                if (controller.text != "") {
                  APIs.sendMessage(user, controller.text, Type.text);
                  controller.clear();
                }
              },
              rippleColor: black,
              borderRadius: radius(100),
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: radius(45), color: appColor),
                child: Image.asset(
                  'assets/icons/send1.png',
                  height: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.user,
  });

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: APIs.getUserInfo(user),
        builder: (context, snapshot) {
          var data;
          final n = snapshot.data?.docs;
          final list =
              n?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
          if (list.isNotEmpty) {
            data = list[0];
          }
          return Row(
            children: [
              IconButtons(
                onTap: () {
                  Nav.pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: black,
                  size: 24,
                ),
              ),
              // sizeW(5),
              ClipRRect(
                borderRadius: radius(45),
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: radius(45),
                      color: imageBg,
                    ),
                    child: NetworkImages(
                        url: list.isEmpty ? user.image : data.image)),
              ),
              sizeW10(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      child: TextFW500(
                    text: list.isEmpty ? user.name : data.name,
                    fontSize: 16,
                    textColor: Colors.black87,
                  )),
                  FittedBox(
                    child: TextFW400(
                      text: list.isEmpty
                          ? MyDateUtils.getLastActiveTime(
                              lastActive: user.lastActive)
                          : data.isOnline
                              ? 'Online'
                              : MyDateUtils.getLastActiveTime(
                                  lastActive: data.lastActive),
                      fontSize: 14,
                      textcolor: textFeildColor,
                    ),
                  ),
                ],
              ))
            ],
          );
        });
  }
}
