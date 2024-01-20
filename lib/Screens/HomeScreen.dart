// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:me_chat/Packages/DropDownMenu.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Screens/ProfileScreen.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import '../Controller/API/Apis.dart';
import '../Utils/Widgets/Chat_User_Card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<ChatUser> list = [];

  String dropMenu = 'Profile';
  var items = ['Profile', 'About', 'Info'];

  @override
  Widget build(BuildContext context) {
    APIs.currentUserInfo();
    return Scaffold(
      appBar: AppBar(
        leading: CP(
          h: 16,
          child: IconButtons(
            onTap: () {},
            icon: const Icon(CupertinoIcons.home),
          ),
        ),
        title: Text(APP_NAME),
        actions: [
          IconButtons(
            onTap: () {},
            icon: const Icon(
              CupertinoIcons.search,
              size: 23,
            ),
          ),
          DropDownMenu(
            color: white,
            textColor: black,
            onSelected: (String value) {
              if (value == 'Profile') {
                Nav.pushMaterial(ProfileScreen(
                  user: APIs.meUser,
                ));
              }
            },
            items: items,
          )
        ],
      ),
      floatingActionButton: Margine(
        margin: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: appColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radius(50)),
          child: Icon(CupertinoIcons.person_add, color: white, size: 26),
        ),
      ),
      body: CP(
        v: 16,
        h: 16,
        child: StreamBuilder(
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data!.docs;
                  list = data.map((e) => ChatUser.fromJson(e.data())).toList();
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          if (index == list.length - 1) {
                            return ChatUserCard(
                              isLast: true,
                              user: list[index],
                            );
                          }

                          return ChatUserCard(
                            isLast: false,
                            user: list[index],
                          );
                        });
                  } else {
                    return Center(
                      child: TextFW400(
                        text: 'No Connections Found!',
                        fontSize: 20,
                        textcolor: appColor,
                      ),
                    );
                  }
              }
            }),
      ),
    );
  }
}
