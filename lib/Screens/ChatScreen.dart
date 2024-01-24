import 'package:flutter/material.dart';
import 'package:me_chat/Controller/ChatController.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/Message_Card.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import 'package:me_chat/models/MessageModel.dart';
import 'package:get/get.dart';
import '../Controller/API/Apis.dart';
import '../Packages/Package_Export.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  final ChatUser user;
  List<Message> list = [];
  ChatController ctr = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizeH(10),
            TopBar(user: user),
            Container(
              height: 10,
              width: DP.infinity(),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: textFeildColor, width: 1.5)),
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
            BottomContainer(
              controller: ctr.chatTextCtr,
              user: user,
            )
          ],
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
  });
  final TextEditingController controller;
  final ChatUser user;
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
                    onTap: () {},
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
                    onTap: () {},
                    icon: Icon(
                      Icons.image,
                      color: appColor,
                      size: 28,
                    ),
                  ),
                  IconButtons(
                    onTap: () {},
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
                APIs.sendMessage(user, controller.text);
                controller.clear();
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
              child: NetworkImages(url: user.image)),
        ),
        sizeW10(),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
                child: TextFW500(
              text: user.name,
              fontSize: 16,
              textColor: Colors.black87,
            )),
            FittedBox(
              child: TextFW400(
                text: "Last seen is not available",
                fontSize: 14,
                textcolor: textFeildColor,
              ),
            ),
          ],
        ))
      ],
    );
  }
}
