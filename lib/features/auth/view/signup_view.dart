import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosaic_communities/common/loading_page.dart';
import 'package:mosaic_communities/features/auth/controller/auth_controller.dart';
import 'package:mosaic_communities/features/auth/view/login_view.dart';

import '../../../common/rounded_small_button.dart';
import '../../../constants/ui_constants.dart';
import '../../../theme/palette.dart';
import '../widgets/auth_fields.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {



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
  
  void onSignUp(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      ref.read(authControllerProvider.notifier).signUp(email: emailController.text, password: passwordController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appBar,
      body: isLoading ? const Loader() : Center(
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
                      onTap: onSignUp,
                      label: "Done",
                      bgColor: Pallete.whiteColor,
                      txtColor: Pallete.backgroundColor,
                    )),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                  text: TextSpan(
                    text: "Already have an Account ?",
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: "  Login",
                        style: TextStyle(color: Pallete.blueColor, fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(context, LoginView.route());
                          },
                      ),
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
