import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_3/screens/otp.dart';

class PhoneHome extends StatelessWidget {
  const PhoneHome({super.key});

  @override
  Widget build(BuildContext context) {
    final phonenumber = TextEditingController();

    Future<void> sendcode() async {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '91' + phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error occured', e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(OtpPage(vid: vid));
          },
          codeAutoRetrievalTimeout: (vid) {},
        );
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error occurred', e.code);
      } catch (e) {
        Get.snackbar('Error Occurred', e.toString());
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset('assets/images/login.png', height: 100, width: 100),
              const Center(
                child: Text(
                  "Login with Mobile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
                child: const Text('We will send you an OTP on this number.', style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 20),
              phonetext(phonenumber),
              const SizedBox(height: 50),
              button(sendcode),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  Widget button(Function sendcode) {
    return Center(
      child: ElevatedButton(
        onPressed: () => sendcode(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.all(16),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            "Receive OTP",
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget phonetext(TextEditingController phonenumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
          style: TextStyle(
            color: Colors.white, // Text input color
          ),
        controller: phonenumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefix: const Text('+91'),
          prefixIcon: const Icon(Icons.phone),
          labelText: 'Enter Phone Number',
          hintStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
        ),
      ),
    );
  }
}
