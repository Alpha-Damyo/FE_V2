import 'package:damyo_app/style.dart';
import 'package:damyo_app/view_models/login_models/islogin_view_model.dart';
import 'package:damyo_app/view_models/login_models/user_info_view_model.dart';
import 'package:damyo_app/widgets/signup_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  
  late UserInfoViewModel _userInfoViewModel;
  late IsloginViewModel _isloginViewModel;
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    _isloginViewModel = Provider.of<IsloginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Expanded(
              child: textFormat(
                text: '간단한 정보를 알려주세요 !',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: signupName(context, nameController),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                signupAge(context, ageController),
                Expanded(child: Container()),
                signupGender(context, _userInfoViewModel),
              ],
            ),
          ),
          Expanded(child: Container()),
          signupCompleteBtn(context, _userInfoViewModel, _isloginViewModel,nameController, ageController),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
