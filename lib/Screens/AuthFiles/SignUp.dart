import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/validators.dart';
import 'package:ausmart/Screens/AuthFiles/OtpScreen.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();

  bool circular = false;
  final storage = new FlutterSecureStorage();

  void validateAndSave() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        circular = true;
      });
      Map<String, String> data = {
        "username": _phoneController.text,
      };
      FlutterSecureStorage storage = FlutterSecureStorage();
      final String token = await storage.read(key: "token");
      final Uri url = Uri.https(baseUrl, apiUrl + "/auth/login");
      final response = await http.post(url, body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        await storage.write(key: "token", value: output["token"]);
        if (output['verified'] == true) {
          await storage.write(key: "verified", value: 'true');
        } else {
          await storage.write(key: "verified", value: 'false');
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phoneNumber: _phoneController.text,
                otp: output["otp"],
                verified: output["verified"],
              ),
            ),
            (route) => false);
      } else {
        showSnackBar(
          duration: Duration(milliseconds: 10000),
          context: context,
          message: "Please Enter a Valid Phone Number",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60.h,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset(
                    'assets/images/login1.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  transform: Matrix4.translationValues(0, -20, 0),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome to ausmart!",
                          style: Text18,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Proxima Nova Font',
                            color: kPinkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Please Enter Your Mobile Number",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Proxima Nova Font',
                            color: kGreyLight,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: phoneValidator,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.green,
                          controller: _phoneController,
                          onChanged: (text) {
                            // mobileNumber = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusColor: Colors.greenAccent,
                            // labelStyle: ktext14,
                            labelText: "Mobile Number",
                            prefixText: "+91 |  ",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: kPinkColor,
                                )),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            "Nb: Enter your current mobile number so as to receive the otp for verification purpose.",
                            style: kTextgrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 420,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: RadialGradient(
                                  colors: [
                                    Color(0xFF666565),
                                    const Color(0xFF555454),
                                  ],
                                  center: Alignment(0, 0),
                                  radius: 3.5,
                                  focal: Alignment(0, 0),
                                  focalRadius: 0.1)),
                          child: new TextButton(
                            // onPressed: () => validateAndSave(),

                            onPressed: () {
                              validateAndSave();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OtpScreen(
                              //       phoneNumber: '',
                              //       otp: null,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Text(
                              'Continue',
                              style: kText145,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  'By continuing you are indicating that you accept our\n',
                              style: kText10,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return PolicyDialog(
                                      //       service: termsAndConditions,
                                      //     );
                                      //   },
                                      // );
                                    },
                                  text: ' Terms of Service',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: kPinkColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: kText10,
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return PolicyDialog(
                                      //       service: privacyPolicy,
                                      //     );
                                      //   },
                                      // );
                                    },
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: kPinkColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
