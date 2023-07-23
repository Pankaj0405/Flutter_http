import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var displayName = '';
  var _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      googleAcc.value = await _googleSignIn.signIn();
      displayName = googleAcc.value!.displayName!;
      isSignedIn.value = true;
      update();
    } catch (e) {
      Get.snackbar("errror occured", e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      displayName = '';
      isSignedIn.value = false;
      update();
    } catch (e) {
      Get.snackbar("error occured", e.toString());
    }
  }
}
