import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/validators.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignupDetails extends StatefulWidget {
  const SignupDetails({Key key}) : super(key: key);

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  bool circular = false;
  final storage = new FlutterSecureStorage();
  void validateAndSave() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        circular = true;
      });
      Map<String, String> data = {
        "email": _emailController.text,
        "name": _nameController.text,
      };
      FlutterSecureStorage storage = FlutterSecureStorage();
      final String token = await storage.read(key: "token");
      final Uri url = Uri.https(baseUrl, apiUrl + "/auth/register/customer");
      final response = await http.post(url, body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> output = json.decode(response.body);
        if (output['data']['verification'] == true) {
          await storage.write(key: "verified", value: 'true');
        } else {
          await storage.write(key: "verified", value: 'false');
        }
        Provider.of<GetDataProvider>(context, listen: false).getData(context);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => BottomNavigation(),
        //     ),
        //     (route) => false);
      } else {
        showSnackBar(
            duration: Duration(milliseconds: 10000),
            context: context,
            message: "User Exist");
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
                child: Image.asset(
                  'assets/images/login3.png',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  transform: Matrix4.translationValues(0, -20, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          "Enter your details",
                          style: Text18Pink1,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Enter your address details, so we can follow up.",
                          style: kTextgrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.green,
                          validator: nameValidator,
                          controller: _nameController,
                          onChanged: (text) {
                            // mobileNumber = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusColor: Colors.greenAccent,
                            // labelStyle: ktext14,
                            labelText: "Name",
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: nameValidator,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.green,
                          controller: _emailController,
                          onChanged: (text) {
                            // mobileNumber = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusColor: Colors.greenAccent,
                            // labelStyle: ktext14,
                            labelText: "Email Address",
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
                        Container(
                          height: 50,
                          width: 420,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: RadialGradient(
                                  colors: [
                                    kPinkColor,
                                    kPinkColor,
                                  ],
                                  center: Alignment(0, 0),
                                  radius: 3.5,
                                  focal: Alignment(0, 0),
                                  focalRadius: 0.1)),
                          child: new TextButton(
                            onPressed: () {
                              validateAndSave();
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => BottomNavigation()),
                              // );
                            },
                            child: Text(
                              'Proceed',
                              style: kTextbuttonwhite,
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
                                    decoration: TextDecoration.underline,
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
                                    decoration: TextDecoration.underline,
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
