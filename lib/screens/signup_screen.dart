import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: Container()),
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(height: 64),
          Stack(children: [
            _image != null
                ? CircleAvatar(
                    radius: 64, backgroundImage: MemoryImage(_image!))
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/default-avatar-profile-image-vector-social-media-user-icon-potrait-182347582.jpg')),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: selectImage,
                icon: const Icon(Icons.add_a_photo),
              ),
            )
          ]),
          const SizedBox(height: 24),
          // Username
          TextFieldInput(
            textEditingController: usernameController,
            hintText: "Enter Your username",
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          // Email
          TextFieldInput(
            textEditingController: emailController,
            hintText: "Enter Your Email",
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          // Password
          TextFieldInput(
            textEditingController: passController,
            hintText: "Enter Your Pass",
            isPass: true,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          // Bio
          TextFieldInput(
            textEditingController: bioController,
            hintText: "Enter Your Bio",
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () async {
              String res = await AuthMethods().signupUser(
                email: emailController.text,
                password: passController.text,
                username: usernameController.text,
                bio: bioController.text,
                file: _image!,
              );
            },
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
              child: const Text("Sign Up"),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text("Don't have an account? "),
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
    ));
  }
}
