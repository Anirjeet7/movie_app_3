import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_3/screens/otp.dart'; // Update to your actual OTP screen file location

class PhoneHome extends StatefulWidget {
  const PhoneHome({super.key});

  @override
  State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  TextEditingController phonenumber = TextEditingController();

  // Function to send the OTP code
  Future<void> sendcode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '91${phonenumber.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error occured', e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(
              OtpPage(
                vid: vid,
              ),
            );
          },
          codeAutoRetrievalTimeout: (vid){}
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error occured', e.code);
    } catch (e) {
      Get.snackbar('Error Occured', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset('assets/images/login.png', height: 100, width: 100),
                Center(
                  child: Text(
                    "Login with Mobile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 15),
                  child: Text('We will send you an OTP on this number.'),
                ),
                const SizedBox(height: 20),
                phonetext(),
                const SizedBox(height: 50),
                button(),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ));
  }

  Widget button() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            sendcode();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, padding: EdgeInsets.all(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Text(
              "Receive OTP",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget phonetext() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: phonenumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefix: Text('+91'),
            prefixIcon: Icon(Icons.phone),
            labelText: 'Enter Phone Number',
            hintStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent))),
      ),
    );
  }
}