import 'dart:convert';
import 'package:EnergyBunker/Constants/Appcolor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Forget_Password extends StatefulWidget {
  const Forget_Password({super.key});

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {


  TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.forgetPassword,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
                children: [
                  SizedBox(height: 25,),
                  Card(
                   // color: Appcolor.PrimaryColor2,
                    elevation: 2,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.forgetPassword,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              SizedBox(height: 10,),
                              Text(AppLocalizations.of(context)!.passwords,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(7),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7),

                                      ),
                                      hintText: AppLocalizations.of(context)!.enterYourEmail,
                                  ),
                                  onSaved: (val) {
                                    //  phone = val;
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a email';
                                    }
                                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(height: 25,),
                              InkWell(
                                onTap: (){
                                  if (_signUpFormKey.currentState?.validate() ?? false);
                                  forgetpassword();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Appcolor.purpleColor
                                  ),
                                  child: Center(child:_isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : Text(AppLocalizations.of(context)!.send,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> forgetpassword() async {
    if (_email.text.isEmpty ) {
      Fluttertoast.showToast(
        msg: "All fields are required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Map<String, String> paramdata = {
      "email": _email.text,
    };
    setState(() {
      _isLoading = true; // Show loader
    });

    try {
      final response = await http.post(
        Uri.parse("https://techimmense.in/EnergyBunker/webservice/forgot_password?email=testuser@gmail.com"),
        body: paramdata,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        print("Response Data: $responseData");

        if (responseData['status'] == "1") { // Check for "1" instead of true
          // Save session data if needed
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', _email.text);

          // Login successful, navigate to Home1
          Fluttertoast.showToast(
            msg: 'Your password has been send your email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         Home1(
          //           email: _email.text,
          //           password: _password.text,
          //         ),
          //   ),
          // );
        } else {
          // Login failed, show the error message
          Fluttertoast.showToast(
            msg: responseData['message'],
            // Display the error message from server
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        print("Login failed with status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred")),
      );

    } finally {
      setState(() {
        _isLoading = false; // Hide loader
      });
    }
  }

}
