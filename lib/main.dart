import 'dart:async';

// import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/chat_bot.dart';
import 'package:login_screen/login_screen.dart';
import 'package:login_screen/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => LoginScreen(),
      'chat_bot': (context) => ChatScreen(),
    },
  ));
}



