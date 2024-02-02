import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

import 'package:me_chat/Packages/Constants.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import 'package:me_chat/models/MessageModel.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Get current user
  static User get user => auth.currentUser!;

  // for storing current user info
  static late ChatUser meUser;

  // Check is user already exist or not
  static userAlreadyExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // For Adding an Chat User for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('>> Data : $data');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      log('>> User Exist ${data.docs.first.data()}');

      // User exist
      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id);
      return true;
    } else {
      // User Doesn't Exist
      return false;
    }
  }

  // Getting current user info
  static Future<void> currentUserInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        meUser = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => currentUserInfo());
      }
    });
  }

  // for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL!,
        name: user.displayName!,
        about: "Hey, I'm using Me Chat!",
        createdAt: time,
        id: user.uid,
        isOnline: false,
        lastActive: time,
        pushToken: "",
        email: user.email!);
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // get all users from database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userids) {
    log("Users $userids");
    return APIs.firestore
        .collection('users')
        .where('id', whereIn: userids.isEmpty ? [''] : userids)
        .snapshots();
  }

  // Get id's of users that i know
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return APIs.firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  static Future<void> sendFirstMessage(
      // This code for when i add a user's email that i know and send the first message but he didn't add me so this code add me to there my_users list
      ChatUser chatUser,
      String msg,
      Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // Update user ingo
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      "name": meUser.name,
      "about": meUser.about,
    }).then((value) => toast('Your Information Updated'));
  }

  // Store image files
  static Future<void> uploadProfileImage(File file) async {
    // # Getting file extension
    final ext = file.path.split('.').last;
    // toast("Extension $ext");

    // # Storage file reference with path
    final ref = storage.ref().child("profile/${user.uid}.$ext");

    // # uploading images
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

    // # Update image url in firestore
    meUser.image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user.uid).update({
      "image": meUser.image,
    }).onError((error, stackTrace) => toast("Error in image Uploading!"));
  }

  // For getting specific user information
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser user) {
    return APIs.firestore
        .collection('users')
        .where('id', isEqualTo: user.id)
        .snapshots();
  }

  // Update Current user active status
  static Future<void> updateUserActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  // Update Current user Push Token
  static Future<void> updateUserPushToken() async {
    firestore.collection('users').doc(user.uid).update({
      'push_token': meUser.pushToken,
    });
  }

  //********************************* Chat Screen Related APIS *********************************/

  // chats (collection) --> conversation_id (docs) --> messages (collection) --> messages (doc)

  // Useful to get conversation id (Compare the two id of sender and receiver and comapre the hash code)
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // get all the messages from firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return APIs.firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy("sent", descending: true)
        .snapshots();
  }

  // for sending messages
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    // message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        fromId: user.uid,
        msg: msg,
        toId: chatUser.id,
        read: '',
        type: type,
        sent: time);
    // toast('1');
    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    // toast('2');

    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
    // toast('3');
  }

  // update message read status
  // when particular message is load check if read is empty if empty then added timestamp of read status
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // Get user last message
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // Send Chat image url
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last;
    // toast("Extension $ext");

    // # Storage file reference with path
    final ref = storage.ref().child(
        "images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");

    // # uploading images
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

    // # Update image url in firestore
    final imageUrl = await ref.getDownloadURL();
    await APIs.sendMessage(chatUser, imageUrl, Type.image);
  }

  // Edit Message
  static Future<void> editMessage(Message message, String msg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': msg}).then((value) => toast('Message updated.'));
  }

  //Delete Message
  static Future<void> deleteMessage(Message message) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  //********************************* Firebase Messaging Stuff *********************************/

  // Get Firebase Messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      if (value != null) {
        meUser.pushToken = value;
        // print(">>>>>>>> ${meUser.pushToken}");
        updateUserPushToken();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got the message');
      log('>>Message : ${message.data}');

      if (message.notification != null) {
        log('message also contains the notification');
      }
    });
  }

  // Sending the push notification
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": chatUser.name,
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {
          "some_data": "abc",
        },
      };

      await post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=AAAAOjOhALg:APA91bFGP-Va_K21PDYH7h103IuegxNOCzApgZJwe3MzadXliKpCvIzWUdReFbLPzZt-FkyTDEkDEQif53IVEvEQiVa0vPxX-w_Zdb6DzW05p6gj0Cswe0p5-czHAH3nvQ542T_nlBA5'
        },
      );
    } catch (e) {
      // print('>>> Error Occured : $e');
    }
  }
}
