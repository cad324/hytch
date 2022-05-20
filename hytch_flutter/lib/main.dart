import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hytch_flutter/navigator.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  var BASE_URI = dotenv.env['BASE_URI_BACKEND'];
  var uid = FirebaseAuth.instance.currentUser!.uid;
  try {
    var response =
        await http.get(Uri.http(BASE_URI!, '/v1/users', {'uid': uid}));
    if (response.body.length != 1) {
      var body = {
        'userId': uid,
        'firstName': FirebaseAuth.instance.currentUser!.displayName,
        'status': FirebaseAuth.instance.currentUser!.emailVerified
            ? 'active'
            : 'inactive',
      };
      await http.post(
        Uri.http(BASE_URI, '/v1/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
    }
  } catch (e) {
    print("[Error creating user] $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(
    //   {
    //     'name': FirebaseAuth.instance.currentUser!.displayName,
    //     'email': FirebaseAuth.instance.currentUser!.email,
    //     'uid': FirebaseAuth.instance.currentUser!.uid,
    //   },
    // );
    Uri.http('127.0.0.1:6047', '/v1/');
    const providerConfigs = [
      EmailProviderConfiguration(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      routes: {
        '/sign-in': (context) =>
            SignInScreen(providerConfigs: providerConfigs, actions: [
              AuthStateChangeAction<SignedIn>((ctx, state) {
                Navigator.pushReplacementNamed(ctx, '/profile');
              }),
            ]),
        '/profile': (context) => AppContainer(),
      },
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        primaryColor: Color.fromARGB(255, 108, 11, 206),
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
        ),
      ),
    );
  }
}
