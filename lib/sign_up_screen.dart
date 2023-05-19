import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/otp_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'google_sign_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String verify = '';
  bool otpSent = false;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: userInput(context),
    );
  }

  Widget userInput(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name:'),
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'A minimum of 3 characters is required';
                    }
                  },
                  onChanged: (value) {
                    // setState(() {});
                  },
                ),
                const SizedBox(height: 7),
                TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Mobile no'),
                  validator: (value) {},
                  onChanged: (value) {
                    // setState(() {});
                  },
                ),
                const SizedBox(height: 7),
                TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'email:'),
                  validator: (value) {
                    // if (value!.length < 3) {
                    //   return 'A minimum of 3 characters is required';
                    // }
                  },
                  onChanged: (value) {
                    // setState(() {});
                  },
                ),
                const SizedBox(height: 7),
                TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password:'),
                  validator: (value) {
                    // if (value!.length < 3) {
                    //   return 'A minimum of 3 characters is required';
                    // }
                  },
                  onChanged: (value) {
                    // setState(() {});
                  },
                ),
                const SizedBox(height: 30),

                //-----------------------------------------------------------
                // Submit btn
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+91${mobileController.text}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        setState(() {
                          verify = verificationId;
                          otpSent = !otpSent;
                        });

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            verificationid: verificationId,
                            name: nameController.toString(),
                            mobileNo: mobileController.toString(),
                            password: passwordController.toString(),
                            // email: emailController.toString(),
                          ),
                        ));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    _handleSignIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Sign with Google',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => OtpScreen(),
                      // ));
                    },
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 23, 247),
                          decoration: TextDecoration.underline,
                          decorationThickness: 2),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // log(userCredential.additionalUserInfo!.profile.toString());
      }
    } catch (error) {}
  }
}
