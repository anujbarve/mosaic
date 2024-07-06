import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosaic_communities/common/rounded_small_button.dart';
import 'package:mosaic_communities/constants/ui_constants.dart';
import 'package:mosaic_communities/features/auth/view/signup_view.dart';
import 'package:mosaic_communities/features/auth/widgets/auth_fields.dart';
import 'package:mosaic_communities/theme/palette.dart';

import '../../../common/loading_page.dart';
import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar = UIConstants.appbar();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLogIn(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      ref.read(authControllerProvider.notifier).logIn(email: emailController.text, password: passwordController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch(authControllerProvider);


    return Scaffold(
      appBar: appBar,
      body: isLoading ? const Loader() :  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmallButton(
                      onTap: onLogIn,
                      label: "Done",
                      bgColor: Pallete.whiteColor,
                      txtColor: Pallete.backgroundColor,
                    )),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account ?",
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                          text: "  Sign Up",
                          style:
                              const TextStyle(color: Pallete.blueColor, fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context, SignUpView.route());
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
