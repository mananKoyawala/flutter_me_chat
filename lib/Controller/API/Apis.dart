import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_chat/Packages/Constants.dart';
import 'package:me_chat/models/ChatUserModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:me_chat/models/MessageModel.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Get current user
  static User get user => auth.currentUser!;

  // for storing current user info
  static late ChatUser meUser;

  // Check is user already exist or not
  static userAlreadyExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
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
    final time = DateTime.now().microsecondsSinceEpoch.toString();
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
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return APIs.firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
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
  static Future<void> sendMessage(ChatUser chatUser, String msg) async {
    // message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        fromId: user.uid,
        msg: msg,
        toId: chatUser.id,
        read: '',
        type: Type.text,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  // update message read status
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
