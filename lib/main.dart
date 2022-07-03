import 'package:fb_app/pages/chat_page.dart';
import 'package:fb_app/pages/home_page.dart';
import 'package:fb_app/pages/login_page.dart';
import 'package:fb_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const FacebookApp());
  
}

class FacebookApp extends StatelessWidget {
  const FacebookApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        LoginPage.id : (context)=> LoginPage(),
        RegisterPage.id :(context) =>  RegisterPage(),
        HomePage.id :(context) => const HomePage(),
        ChatPage.id:(context) => ChatPage()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'HomePage',
    );
  }
}
