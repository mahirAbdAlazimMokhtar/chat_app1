import 'package:fb_app/pages/chat_page.dart';
import 'package:fb_app/pages/register_page.dart';
import 'package:fb_app/widgets/custom_button.dart';
import 'package:fb_app/widgets/custom_text_field.dart';
import 'package:fb_app/widgets/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_shadow.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'loginPage';
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? password;

  String? email;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //this is image for login
                  CustomShadow(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: const Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/login.jpeg'),
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Chat App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login In",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadow(
                    child: CustomTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      onTap: () {},
                      hint: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadow(
                    child: CustomTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      obscureText: true,
                      onTap: () {},
                      hint: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //this for login in
                  CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await loginUser();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'wrong-password') {
                              showSnackbar(context, 'the password too short');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackbar(context, 'no user found ');
                            } else {}
                          } catch (e) {
                            showSnackbar(context, 'there was an error');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      text: 'Sing In'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account ?",
                        ),
                        GestureDetector(
                          child: const Text(
                            "  Sing Up",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
