import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/is_login_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/setting/login_widgets.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late IsloginViewModel _isloginViewModel;
  late TokenViewModel _tokenViewModel;
  late UserInfoViewModel _userInfoViewModel;

  @override
  Widget build(BuildContext context) {
    _isloginViewModel = Provider.of<IsloginViewModel>(context);
    _tokenViewModel = Provider.of<TokenViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: appbarTitleFormat(text: "로그인 / 회원가입"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            naverLoginBtn(context, _isloginViewModel, _tokenViewModel,
                _userInfoViewModel),
            const SizedBox(height: 15),
            googleLoginBtn(context, _isloginViewModel, _tokenViewModel,
                _userInfoViewModel),
          ],
        ),
      ),
    );
  }
}
