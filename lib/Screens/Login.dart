import 'dart:convert';
import 'package:EnergyBunker/Constants/language_provider.dart';
import 'package:EnergyBunker/Screens/Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Constants/Appcolor.dart';
import 'Forget_Password.dart';
import 'SingUp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {



  TextStyle basicText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  bool passwordVisible=false;
  bool _isLoading = false; // Loading state variable

  String selectedLocale = '';

  @override
  void initState() {
    // _email.clear();
    // _password.clear();
    super.initState();
    passwordVisible=true;
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'SPANISH','locale': Locale('es','ES')},
    {'name':'CATALAN','locale': Locale('ca','CA')},
  ];
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  // buildLanguageDialog(BuildContext context){
  //   showDialog(context: context,
  //       builder: (builder){
  //         return AlertDialog(
  //           title: Text('Choose Your Language'),
  //           content: Container(
  //             width: double.maxFinite,
  //             child: ListView.separated(
  //                 shrinkWrap: true,
  //                 itemBuilder: (context,index){
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
  //                       print(locale[index]['name']);
  //                       updateLanguage(locale[index]['locale']);
  //                     },),
  //                   );
  //                 }, separatorBuilder: (context,index){
  //               return Divider(
  //                 color: Colors.blue,
  //               );
  //             }, itemCount: locale.length
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8,),
            Expanded(child: Text(AppLocalizations.of(context)!.login,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
           DropdownMenu(
             hintText: "Select language",
             textStyle: TextStyle(color: Colors.black),
               initialSelection: Text(context.watch<LanguageProvider>().selectedLocale.languageCode),
               onSelected: (value){
                context.read<LanguageProvider>().changeLanguage(value as String);
               },
               dropdownMenuEntries: LanguageProvider.languages.map((language) =>
               DropdownMenuEntry(
                   value: language['locale'],
                   label: language['name']
               )
               ).toList(),
           )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,

              child: Form(
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Center(
                    child: Text(AppLocalizations.of(context)!.accessToThePriceRoom,textAlign: TextAlign.center,
                    style: basicText,),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: Text(AppLocalizations.of(context)!.toEnterThePriceRoomYouMustBeRegistered,textAlign: TextAlign.center,
                    style: smallText,),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.enterYourEmail,
                      style: smallText,
                      children: <TextSpan>[
                        TextSpan(text: '*', style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Appcolor.themeColor)),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                       controller: _email,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(7),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)
                          ),
                          hintText: AppLocalizations.of(context)!.enterYourEmail,
                          filled: true,
                         // fillColor: Appcolor.PrimaryColor1
                      ),
                      onSaved: (val) {
                        //  phone = val;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un correo electrónico';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Por favor introduce un correo electrónico válido';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.enterYourPassword,
                      style: smallText,
                      children: <TextSpan>[
                        TextSpan(text: '*', style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Appcolor.themeColor)),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                     controller: _password,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        hintText: AppLocalizations.of(context)!.enterYourPassword,
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                                  () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        filled: true,
                        //fillColor: Appcolor.PrimaryColor1
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => Forget_Password(),));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!.forgetPassword,textAlign: TextAlign.end,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                        if (_signUpFormKey.currentState?.validate() ?? false)
                          login();
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Service(),));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Appcolor.purpleColor
                      ),
                      child: Center(
                        child:_isLoading
                            ?  CircularProgressIndicator(color: Colors.white)
                            :  Text(AppLocalizations.of(context)!.login, style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),),),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.dontHaveAccount, style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const SingUp(),));
                          },
                          child:  Text(AppLocalizations.of(context)!.register, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Appcolor.PrimaryColor),))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> login() async {
    SVProgressHUD.show(); // Show loading indicator
    if (_email.text.isEmpty || _password.text.isEmpty) {
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
      "password": _password.text,
     // "user_id": 'userId',
    };
    setState(() {
      _isLoading = true; // Show loader
    });

    try {
      final response = await http.post(
        Uri.parse("https://techimmense.in/EnergyBunker/webservice/login"),
        body: paramdata,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        print("Response Data: $responseData");

        String status = responseData['status'];

        if (status == "2") { // Check for "1" instead of true
          // Save session data if needed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
               // title: Text("Login Failed"),
                content: Text(AppLocalizations.of(context)!.approved,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                actions: <Widget>[
                  TextButton(
                    child: Center(
                      child: Container(
                        height: 48,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Appcolor.purpleColor
                          ),
                          child: Center(child: Text(AppLocalizations.of(context)!.ok,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                    ),

                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );

            },
          );
        } else if (status == "1") {
          // Login failed, show the error message
          String userId = responseData['result']['id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', _email.text);
          await prefs.setString('password', _password.text);
          await prefs.setString('user_id', userId); // Save user ID
          await prefs.setString('selectedLocale', selectedLocale);
          // Login successful, navigate to Home1
          Fluttertoast.showToast(
            msg: responseData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Service(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: responseData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print("Login failed with status: ${response.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("")),
          );
        }
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
    SVProgressHUD.dismiss(); // Dismiss loading indicator
  }

}

