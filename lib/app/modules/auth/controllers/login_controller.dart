import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../root/controllers/root_controller.dart';
class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  loginWithGoogle() async {
    print('check');
    try {
      print('check');
      final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await     _auth.signInWithCredential(credential);

      final User user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      await Get.find<RootController>().changePage(0);; // navigate to your wanted page
      return;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }

}