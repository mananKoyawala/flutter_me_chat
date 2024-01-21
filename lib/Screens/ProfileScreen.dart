// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Controller/Profile_Controller.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/Widgets/Network_Image.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import 'package:get/get.dart';
import '../Controller/Login_Controller.dart';
import '../Utils/AppBaar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key, required this.user});
  final ChatUser user;
  ProfileController ctr = Get.put(ProfileController());
  LoginController ctrL = Get.find<LoginController>();

  onButtonClick() {
    if (ctr.formKey.currentState!.validate()) {
      APIs.meUser.name = ctr.nameCtr.text;
      APIs.meUser.about = ctr.aboutCtr.text;
      APIs.updateUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    ctr.changeNameCtr(user.name);
    ctr.changeAboutCtr(user.about);
    var image = 120.0;
    return GestureDetector(
      onTap: () => unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              sizeH(30),
              const CustomAppBar(title: "Profile Screen"),
              CP(
                h: 16,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sizeH25(),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: radius(image),
                            child: Container(
                              height: image,
                              width: image,
                              decoration: BoxDecoration(
                                color: imageBg,
                                borderRadius: radius(image),
                              ),
                              child: NetworkImages(url: user.image),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 2,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: appColor,
                              child: IconButtons(
                                onTap: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: white,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      sizeH(40),
                      FittedBox(
                          child: TextFW400(
                              text: user.email,
                              fontSize: 16,
                              textcolor: black)),
                      sizeH(60),
                      Form(
                          key: ctr.formKey,
                          child: Column(
                            children: [
                              TheTextFeild(
                                funValidate: (val) {
                                  if (val != null && val.isEmpty) {
                                    return "Name is Required";
                                  }
                                  return null;
                                },
                                isborder: true,
                                labelText: "Name",
                                prefixIcon: Icon(Icons.person, color: appColor),
                                borderRadius: 10,
                                hintStyle: TextStyle(color: textFeildColor),
                                fieldColor: Colors.grey.shade400,
                                controller: ctr.nameCtr,
                                onClickColor: appColor,
                                borderWidth: 1.5,
                                hintText: "eg. Happy Singh",
                              ),
                              sizeH(25),
                              TheTextFeild(
                                funValidate: (val) {
                                  if (val != null && val.isEmpty) {
                                    return "About is Required";
                                  }
                                  return null;
                                },
                                maxLength: 30,
                                isborder: true,
                                labelText: "About",
                                prefixIcon:
                                    Icon(Icons.info_outline, color: appColor),
                                borderRadius: 10,
                                hintStyle: TextStyle(color: textFeildColor),
                                fieldColor: Colors.grey.shade400,
                                controller: ctr.aboutCtr,
                                onClickColor: appColor,
                                borderWidth: 1.5,
                                hintText: "eg. Hey, I'm using Me Chat!",
                              ),
                            ],
                          )),
                      sizeH(60),
                      ButtonWithPrefixIcon(
                        height: 50,
                        width: 200,
                        onTap: () {
                          onButtonClick();
                        },
                        prefixIcon: Icon(
                          Icons.login,
                          color: white,
                        ),
                        backgroundColor: appColor,
                        title: TextFW400(
                          text: 'UPDATE',
                          fontSize: 16,
                          textcolor: white,
                        ),
                      ),
                      sizeH(30),
                      ButtonWithPrefixIcon(
                        height: 50,
                        width: 140,
                        onTap: () {
                          decisionDialog(
                              'Log out',
                              'Are You Sure You want to Logout?',
                              "No",
                              "Yes", () {
                            Nav.pop();
                          }, () {
                            ctrL.handleGoogleSignOut();
                          });
                        },
                        prefixIcon: Icon(
                          Icons.logout,
                          color: white,
                        ),
                        backgroundColor: Colors.red.shade400,
                        title: TextFW400(
                          text: 'Logout',
                          fontSize: 16,
                          textcolor: white,
                        ),
                      ),
                      sizeH25()
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
