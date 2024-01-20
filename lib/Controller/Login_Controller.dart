import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_chat/Controller/API/Apis.dart';
import 'package:me_chat/Screens/HomeScreen.dart';

import '../Packages/Package_Export.dart';
import '../Screens/Auth/Login_Screen.dart';
import '../Utils/Dialogs.dart';

class LoginController extends GetxController {
  handleGoogleBtnClick() {
    Dialogs.showProgressBar();
    signInWithGoogle().then((user) async {
      if (user != null) {
        // print("User >>>>>>>>>> : ${user.user}");
        // print("User >>>>>>>>>> : ${user.additionalUserInfo}");
        if ((await APIs.userAlreadyExist())) {
          Dialogs.removeProgressBar();
          Nav.pushMaterialReplacement(HomeScreen());
        } else {
          Dialogs.removeProgressBar();
          await APIs.createUser()
              .then((value) => Nav.pushMaterialReplacement(HomeScreen()));
        }
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      toast("Can't Sign-in, Please try again");
    }
    return null;
  }

  handleGoogleSignOut() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    Nav.pop();
    Nav.pop();
    Nav.pushMaterialReplacement(LoginScreen());
  }
}
