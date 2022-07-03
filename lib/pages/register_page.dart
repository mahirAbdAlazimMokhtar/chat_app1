import 'package:fb_app/pages/chat_page.dart';
import 'package:fb_app/widgets/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_shadow.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RegisterPage({
    Key? key,
    
  });
  static String id = 'registerPage';
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
 


  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  //this is image for login
                  CustomShadow(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: const Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/register.jpeg'),
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
                    "Register",
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
                      onTap: () {},
                      hint: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomShadow(
                    child: CustomTextField(
                      onTap: () {},
                      hint: 'password',
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await userRegister();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, ChatPage.id,
                             );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackbar(context, 'the password too short');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackbar(context, 'email already exists');
                            } else {}
                          } catch (e) {
                            showSnackbar(context, 'there was an error');
                          }
                          setState(() {});
                          isLoading = false;
                        }
                      },
                      text: 'Register'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ?",
                        ),
                        GestureDetector(
                          child: const Text(
                            "  Sing In",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.pop(context);
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

  Future<UserCredential> userRegister() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    return user;
  }
}
