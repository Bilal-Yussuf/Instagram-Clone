import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passController.text,
    );
    if (res == 'Success') {
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 2, child: Container()),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 64),
                TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter Your Email",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: passController,
                  hintText: "Enter Your Pass",
                  isPass: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                    child: _isLoading
                        ? const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                        : const Text("Login"),
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(flex: 2, child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Dont have an account"),
                    ),
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Sign up",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
