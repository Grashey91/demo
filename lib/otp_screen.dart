import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/shared_pref.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OtpScreen extends StatefulWidget {
  String verificationid;
  String name;
  // String email;
  String mobileNo;
  String password;
  OtpScreen({
    super.key,
    required this.verificationid,
    required this.name,
    required this.mobileNo,
    required this.password,
    // required this.email
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otp Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              controller: otpcontroller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Otp'),
              validator: (value) {
                // if (value!.length < 3) {
                //   return 'A minimum of 3 characters is required';
                // }
              },
              onChanged: (value) {
                setState(() {});
              },
            ),

            SizedBox(height: 50),
            //--------------------------
            InkWell(
              onTap: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationid,
                    smsCode: otpcontroller.text);

                // Sign the user in (or link) with the credential
                // await auth.signInWithCredential(credential);

                UserCredential userCredential =
                    await auth.signInWithCredential(credential);

                CollectionReference user =
                    FirebaseFirestore.instance.collection('user');

                user.add({
                  'mobile': userCredential.user?.phoneNumber ?? '',
                  'uId': userCredential.user?.uid ?? '',
                  'name': widget.name,
                  // 'email': widget.email,
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Home(),
                ));
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Verify Otp',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
