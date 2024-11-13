import 'dart:convert';
import 'package:EnergyBunker/Screens/Privacy_Policy.dart';
import 'package:EnergyBunker/Screens/Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Appcolor.dart';
import 'Login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {

  TextStyle basicText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  String dropdownValue = 'A';


  bool passwordVisible = false;
  bool _isLoading = false; // Loading state variable

  @override
  void initState() {
    // _email.clear();
    // _password.clear();
    super.initState();
    fetchDataFromApi();
    passwordVisible = true;
  }

  bool value = false;

  bool value1 = false;

  bool value2 = false;

  // final List<String> _type = ['08256-Artes-Barcelona','08279-Avinya-Barcelona','08214-Badia-Barcelona','08210-Barbera-Barcelona'];
  //
  // // the selected value
  // String? _selectedtype;

  String? postalid = '';
  String? postalcode = '';

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _number = TextEditingController();

  bool isChecked7 = false;

  List<String> _types = [];
  String? _selectedType;

  // -------------------- Postal ID ----------------------------//

  Future<void> fetchDataFromApi() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace with your actual API endpoint
      final response = await http.get(Uri.parse(
          'https://techimmense.in/EnergyBunker/webservice/postal_code_list'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        List<dynamic> result = data['result'];

        // Extracting id and postal_code
        List<Map<String, dynamic>> extractedData = result.map((item) {
          return {
            'id': item['id'],
            'postal_code': item['postal_code'],
          };
        }).toList();

        // Save the extracted data into SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (var item in extractedData) {
          await prefs.setString('id${item['id']}', item['id']);
          await prefs.setString(
              'postal_code${item['postal_code']}', item['postal_code']);
        }

        // You can now update your state with the extracted data
        setState(() {
          _types = extractedData.map((item) => item['postal_code'] as String)
              .toList();
          _selectedType = _types.isNotEmpty ? _types[0] : null;
        });

        await _loadData();

        // If you need the extracted data somewhere else
        print(extractedData);
      } else {
        // Handle error
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // isChecked21 = prefs.getBool('isChecked21') ?? false;
      postalid = prefs.getString('id') ?? '';
      postalcode = prefs.getString('postal_code') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back))),
            SizedBox(width: 8,),
            Text(AppLocalizations.of(context)!.register,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                children: [
                  SizedBox(height: 30,),
                  Center(child: Text(
                    AppLocalizations.of(context)!.sign, style: basicText,
                    textAlign: TextAlign.center,)),
                  SizedBox(height: 5,),
                  Center(child: Text(
                    AppLocalizations.of(context)!.enjoy, style: smallText,
                    textAlign: TextAlign.center,)),
                  SizedBox(height: 30,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.firstName,
                      style: smallText,
                      children: <TextSpan>[
                        TextSpan(text: '*', style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Appcolor.themeColor)),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: AppLocalizations.of(context)!.firstName,

                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.enterLast,
                      style: smallText,
                      children: <TextSpan>[
                        TextSpan(text: '*', style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Appcolor.themeColor)),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _lastname,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: AppLocalizations.of(context)!.enterLast,
                      // filled: true,
                      //  fillColor: Appcolor.PrimaryColor1
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un apellido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildDropdown(
                    AppLocalizations.of(context)!.postalCode,
                    _types,
                    _selectedType,
                        (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
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
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        hintText: AppLocalizations.of(context)!.enterYourEmail,
                        //  filled: true,
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
                  SizedBox(
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
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.all(7),
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
                      // filled: true,
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
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.confirmPassword,
                      style: smallText,
                      children: <TextSpan>[
                        TextSpan(text: '*', style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Appcolor.themeColor)),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    // controller: _cpassword,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: AppLocalizations.of(context)!.confirmPassword,
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
                      //  filled: true,
                      //fillColor: Appcolor.PrimaryColor1
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor confirme su nueva contraseña';
                      }
                      if (value != _password.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Text("Enter Contact number",
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // TextFormField(
                  //   // controller: _number,
                  //   inputFormatters: [
                  //     LengthLimitingTextInputFormatter(10), // Restrict input to 10 characters
                  //     FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  //   ],
                  //   decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.all(7),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(7)
                  //       ),
                  //       hintText: "Enter your number",
                  //       filled: true,
                  //       //fillColor: Appcolor.PrimaryColor1
                  //   ),
                  //   keyboardType: TextInputType.phone,
                  //   onSaved: (val) {
                  //     //  phone = val;
                  //   },
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter a number';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isChecked7 = !isChecked7;
                          });
                        },
                        child: isChecked7
                            ? Icon(Icons.check_box, color: Colors.blue)
                            : Icon(Icons.check_box_outline_blank_outlined,),
                      ),
                      SizedBox(width: 3),
                      Text(AppLocalizations.of(context)!.accept,
                        style: TextStyle(fontSize: 10.5, color: Colors.grey),),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Privacy_Policy(),));
                          },
                          child: Text(AppLocalizations.of(context)!.policy,
                            style: TextStyle(fontSize: 9, color: Colors.blue),))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_signUpFormKey.currentState?.validate() ?? false) {
                        if (isChecked7) {
                          // Proceed with registration if checkbox is checked
                          register();
                        } else {
                          // Show a warning message if checkbox is not checked
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please accept the terms and conditions to proceed'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Appcolor.purpleColor
                      ),
                      child: Center(child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(AppLocalizations.of(context)!.register,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.an, style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Login(),));
                          },
                          child: Text(AppLocalizations.of(context)!.good,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Appcolor.PrimaryColor),))
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       activeColor: Colors.blue,
                  //       value: this.value,
                  //       onChanged: (value) => setState(() {
                  //           this.value = value!;
                  //         }),
                  //     ),
                  //     Text('I have read accept the conditions of Use and the  ',style: TextStyle(fontSize: 10,color: Colors.grey),),
                  //     Text('privacy policy',style: TextStyle(fontSize: 10,color: Colors.blue),)
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       activeColor: Colors.blue,
                  //       value: this.value1,
                  //       onChanged: (value) => setState(() {
                  //         this.value1 = value!;
                  //       }),
                  //     ),
                  //     Center(child: Text('I want to receive offers and information about the best prices\nfor diesel groups in my town (recommended)  ',style: TextStyle(fontSize: 10,color: Colors.grey),textAlign: TextAlign.center,)),
                  //     //Text('privacy policy',style: TextStyle(fontSize: 10,color: Colors.blue),)
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       activeColor: Colors.blue,
                  //       value: this.value2,
                  //       onChanged: (value) => setState(() {
                  //         this.value2 = value!;
                  //       }),
                  //     ),
                  //     Center(child: Text('I want to receive advertising, news and newsletters to my email  ',style: TextStyle(fontSize: 10,color: Colors.grey),textAlign: TextAlign.center,)),
                  //     //Text('privacy policy',style: TextStyle(fontSize: 10,color: Colors.blue),)
                  //   ],
                  // ), //Check//Checkbox


                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildDropdown(String label,
      List<String> items,
      String? selectedItem,
      ValueChanged<String?> onChanged,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Appcolor.blackColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton<String>(
            value: selectedItem,
            onChanged: onChanged,
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select $label',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            underline: Container(),
            dropdownColor: Colors.white,
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.black,
              ),
            ),
            isExpanded: true,
            items: items
                .map(
                  (e) =>
                  DropdownMenuItem<String>(
                    value: e,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
            )
                .toList(),
            selectedItemBuilder: (BuildContext context) =>
                items
                    .map(
                      (e) =>
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                )
                    .toList(),
          ),
        ),
      ],
    );
  }


  // ------------------- Postal code API ---------------------//


  // ------------------  SignUp API -------------------------//
  Future<void> register() async {
    // const String url = "https://techimmense.in/foodoo/webservice/signup";
    if (_name.text.isEmpty ||
        _lastname.text.isEmpty ||
        _email.text.isEmpty ||
        _password.text.isEmpty) {
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
      "first_name": _name.text,
      "last_name": _lastname.text,
      "email": _email.text,
      "password": _password.text,
      "postal_code_id": postalid!,
      "postal_code": _selectedType!,
      "register_id": "",
      "mobile": "",
      "date_time": ""
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://techimmense.in/EnergyBunker/webservice/signup"),
        body: paramdata,
      );

      if (response.statusCode == 200) {
        var Data = jsonDecode(response.body);
        print(Data['message']);
        print(Data);
        print(Data['status']);

        String status = Data['status'];

        if (status == "0") { // Check for "1" instead of true

          Fluttertoast.showToast(
            msg: Data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));

        } else if (status == "1") {

          String userId = Data['result']['id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', _email.text);
          await prefs.setString('password', _password.text);
          await prefs.setString('user_id', userId); // Save user ID
          await prefs.setString('postal_code', _selectedType!);


          Fluttertoast.showToast(
            msg: Data['message'],
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
                  Login(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: Data['message'],
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
  }

}

