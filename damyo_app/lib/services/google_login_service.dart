import 'package:damyo_app/services/login_service.dart';
import 'package:damyo_app/services/login_state_check.dart';
import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<int> signInWithGoogle(
    IsloginViewModel isloginViewModel, TokenViewModel tokenViewModel) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    return -1;
  }

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleUser.authentication;
  Map<String, dynamic> userInfo;

  // google accesstoken 받아오기
  String googleAccessToken = googleSignInAuthentication.accessToken.toString();

  userInfo = await login({
    "token": googleAccessToken,
  }, "google");

  return await checkLoginState(userInfo, isloginViewModel, tokenViewModel);
}
