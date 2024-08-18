import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/token_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damyo_app/widgets/login_widgets.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            naverLoginBtn(context, _isloginViewModel, _tokenViewModel, _userInfoViewModel),
            testBtn(context),
          ],
        ),
      ),
    );
  }
}
