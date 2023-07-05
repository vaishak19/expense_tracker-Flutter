import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstLogin extends StatefulWidget {
  const FirstLogin({super.key});
  static String verify = '';

  @override
  State<FirstLogin> createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  final _formKey = GlobalKey<FormState>();

  final _countryController = TextEditingController();

  var phone = '';

  @override
  void initState() {
    _countryController.text = '+91';
    super.initState();
  }

  Object? validator(value) {
    if (value!.isEmpty) {
      return ('Please enter Phone No.');
    }
    if (value.length != 10) {
      return 'Phone No. must be of 10 digit';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'images/rupee.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "\nWelcome User!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  child: Text(
                    ' Please Enter your Phone Number:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5, left: 10),
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_android_rounded,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          height: 50,
                          width: 40,
                          child: TextField(
                            controller: _countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              phone = val;
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Phone No.';
                              }
                              if (value.length != 10) {
                                return 'Phone No. must be of 10 digit';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 16, bottom: 10),
                                errorStyle:
                                    TextStyle(fontSize: 12, height: 0.1),
                                border: InputBorder.none,
                                hintText: "Phone No.",
                                hintStyle: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (() async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: _countryController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          FirstLogin.verify = verificationId;
                          Navigator.pushNamed(context, 'Login_2');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      /*if (_formKey.currentState?.validate() == false) {
                        const Text('Invalid Input');
                      } else {
                        //Navigator.pushNamed(context, 'Login_2');
                      }*/
                    }),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Get OTP',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
