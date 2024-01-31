// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:me_chat/Controller/HomeController.dart';
import 'package:me_chat/Packages/DropDownMenu.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Screens/ProfileScreen.dart';
import 'package:me_chat/Screens/ChatScreen.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import '../Controller/API/Apis.dart';
import '../Utils/Services/NavigatorServices.dart';
import '../Utils/Widgets/Chat_User_Card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<ChatUser> list = [];
  List<ChatUser> searchResult = [];
  DateTime? _lastBackPressed;

  HomeController ctr = Get.put(HomeController());

  String dropMenu = 'Profile';
  var items = ['Profile', 'About', 'Info'];

  showAddUserDialog() {
    showDialog(
        context: ncontext,
        builder: (_) {
          return AlertDialog(
            surfaceTintColor: white,
            backgroundColor: white,
            shape: RoundedRectangleBorder(borderRadius: radius(20)),
            title: Row(
              children: [
                Icon(Icons.person, color: appColor),
                sizeW(15),
                TextFW400(text: 'Add User', fontSize: 18, textcolor: black)
              ],
            ),
            content: Form(
              key: ctr.formKey,
              child: TheTextFeild(
                funValidate: (val) {
                  if (val != null && val.isEmpty) {
                    return "Please enter email address";
                  } else if (val != null && !(GetUtils.isEmail(val))) {
                    return "Enter valid email address";
                  }
                  return null;
                },
                isborder: true,
                borderRadius: 10,
                hintStyle: TextStyle(color: textFeildColor),
                fieldColor: Colors.grey.shade400,
                controller: ctr.addUserCtr,
                onClickColor: appColor,
                borderWidth: 1.5,
                hintText: "Email Id",
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWithSimpleText(
                    onTap: () {
                      Nav.pop();
                      ctr.addUserCtr.clear();
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
                        APIs.addChatUser(ctr.addUserCtr.text).then((value) => {
                              if (!value) {toast('User does not exist!')}
                            });
                        ctr.addUserCtr.clear();
                      }
                    },
                    title: TextFW400(
                        text: 'Add User', fontSize: 16, textcolor: white),
                    width: 100,
                    backgroundColor: appColor,
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    APIs.currentUserInfo();
    return WillPopScope(
      onWillPop: () {
        if (ctr.isSearching.value) {
          ctr.changeIsSearching();
          return Future.value(false);
        } else {
          if (_lastBackPressed == null ||
              DateTime.now().difference(_lastBackPressed!) >
                  const Duration(seconds: 5)) {
            // Notify user to press back again immediately

            toast("Press back again to exit");
            _lastBackPressed = DateTime.now();
            return Future.value(false);
          } else {
            // If pressed again within 2 seconds, allow app exit
            return Future.value(true);
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: CP(
              h: 16,
              child: IconButtons(
                onTap: () {},
                icon: const Icon(CupertinoIcons.home),
              ),
            ),
            title: Obx(() => ctr.isSearching.value
                ? SearchField(controller: ctr.searchCtr)
                : Text(APP_NAME)),
            actions: [
              IconButtons(
                onTap: () {
                  ctr.changeIsSearching();
                },
                icon: Obx(
                  () => Icon(
                    ctr.isSearching.value
                        ? CupertinoIcons.clear_circled_solid
                        : CupertinoIcons.search,
                    size: 23,
                  ),
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
              onPressed: () {
                showAddUserDialog();
              },
              backgroundColor: appColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: radius(50)),
              child: Icon(CupertinoIcons.person_add, color: white, size: 26),
            ),
          ),
          body: CP(
            v: 16,
            // h: 16,
            child: StreamBuilder(
                stream: APIs.getMyUsersId(),
                builder: (context, snapshot) {
                  final newdata =
                      snapshot.data?.docs.map((e) => e.id).toList() ?? [];

                  // Show those user that current user knows
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
                      return StreamBuilder(
                          stream: APIs.getAllUsers(newdata),
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
                                list = data
                                    .map((e) => ChatUser.fromJson(e.data()))
                                    .toList();
                                if (list.isNotEmpty) {
                                  return ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return ChatUserCard(
                                          onTap: () {
                                            Nav.pushMaterial(
                                                ChatScreen(user: list[index]));
                                          },
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
                          });
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 40,
      child: TheTextFeild(
        autofocus: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        funValidate: (val) {
          return null;
        },
        isborder: false,
        borderRadius: 10,
        hintStyle: TextStyle(color: textFeildColor),
        fieldColor: Colors.grey.shade400,
        controller: controller,
        onClickColor: appColor,
        borderWidth: 1.5,
        hintText: "Search Here...",
      ),
    );
  }
}
