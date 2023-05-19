import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/sign_up_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      _googleSignIn.signInSilently().then((value) {
        if (value != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ));
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
