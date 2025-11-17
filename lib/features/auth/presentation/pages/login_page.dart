import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/res/styles/app_sytle.dart';
import 'package:mpdam/core/widgets/appbar/celestial_app_bar.dart';
import 'package:mpdam/core/widgets/button/celestial_button_basic.dart';
import 'package:mpdam/core/widgets/button/celestial_link_button.dart';
import 'package:mpdam/core/widgets/label/celestial_label.dart';
import 'package:mpdam/core/widgets/textbox/email_textbox.dart';
import 'package:mpdam/core/widgets/textbox/password_textbox.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailTextCon;
  late final TextEditingController passwordTextCon;

  @override
  void initState() {
    emailTextCon = TextEditingController(text: "weslyaioria@gmail.com");
    passwordTextCon = TextEditingController(text: "a123456");
    super.initState();
  }

  @override
  void dispose() {
    emailTextCon.dispose();
    passwordTextCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CelestialAppBar(hideBack: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CelestialLabel(text: "Sign in", style: AppStyle.signStyle),
            const SizedBox(height: 20),

            /// Email textbox
            EmailText(textController: emailTextCon, hintText: "Enter Email"),
            const SizedBox(height: 20),

            /// Password textbox
            PasswordText(
              textController: passwordTextCon,
              hintText: "Enter Password",
            ),
            const SizedBox(height: 20),

            /// BUTTON + LOADING
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return CelestialButtonBasic(
                title: 'Continue',
                onPressed: () {
                  controller.login(
                    context,
                    emailTextCon.text.trim(),
                    passwordTextCon.text.trim(),
                  );
                },
              );
            }),

            const SizedBox(height: 20),

            /// LINK REGISTER
            Row(
              children: [
                const CelestialLabel(text: "Don't you have an account? "),
                CelestialLinkButton(
                  onTap: () => context.pushNamed("register"),
                  style: AppStyle.buttonLink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
