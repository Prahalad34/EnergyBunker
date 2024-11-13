
import 'package:EnergyBunker/Screens/Complete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Appcolor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Account extends StatefulWidget {
  const Account({super.key, required Map<String, dynamic> selectedItem});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

 bool  isChecked21 = false;
 bool  isChecked11 = false;
 bool  isChecked12 = false;

  bool value1 = false;

  bool value2 = false;

  TextStyle basicText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);

  String dropdownValue = 'press';


 // final List<String> _type = ['08256-Artes-Barcelona','08279-Avinya-Barcelona','08214-Badia-Barcelona','08210-Barbera-Barcelona'];
 //
 // // the selected value
 // String? _selectedtype;

 // final List<String> _how = [AppLocalizations.of(context)!.press,AppLocalizations.of(context)!.pressed];

 // the selected value
 String? _selectedhow;

 TextEditingController company = TextEditingController();
 TextEditingController cif = TextEditingController();
 TextEditingController name = TextEditingController();
 TextEditingController surname = TextEditingController();
 TextEditingController lastname = TextEditingController();
 TextEditingController dninie = TextEditingController();
 TextEditingController phone = TextEditingController();
 TextEditingController alternative = TextEditingController();
 TextEditingController address = TextEditingController();
 TextEditingController urbanization = TextEditingController();
 TextEditingController postal = TextEditingController();



 @override
 void initState() {
   super.initState();
   _retrieveName();
 }

 // Future<void> fetchDataFromApi() async {
 //   setState(() {
 //     _isLoading = true;
 //   });
 //
 //   try {
 //     // Replace with your actual API endpoint
 //     final response = await http.get(Uri.parse('https://techimmense.in/EnergyBunker/webservice/postal_code_list'));
 //
 //     if (response.statusCode == 200) {
 //       final data = json.decode(response.body);
 //       print(data);
 //       List<dynamic> result = data['result'];
 //
 //       setState(() {
 //         _types = result.map((item) => item['postal_code'] as String).toList();
 //         _selectedType = _types.isNotEmpty ? _types[0] : null;
 //       });
 //     } else {
 //       // Handle error
 //       print('Failed to load data');
 //     }
 //   } catch (e) {
 //     print('Error fetching data: $e');
 //   } finally {
 //     setState(() {
 //       _isLoading = false;
 //     });
 //   }
 // }

 String? _savedNumber;

 // @override
 // void initState() {
 //   super.initState();
 //   _retrieveName();
 // }

 Future<void> _retrieveName() async {
   final prefs = await SharedPreferences.getInstance();

   // Check where the name is saved before or not
   if (!prefs.containsKey('postal')) {
     print(prefs.getString('postal'));
     return;
   }

   setState(() {
     print(" vadsf == " + prefs.getString('postal').toString());
     _savedNumber = prefs.getString('postal');
     postal.text = _savedNumber!;
   });
 }

 Future<void> saveFormData() async {
   final prefs = await SharedPreferences.getInstance();

   // Save the form data to SharedPreferences
   await prefs.setBool('isChecked21', isChecked21);
   await prefs.setString('company_name', company.text);
   await prefs.setString('cif', cif.text);
   await prefs.setString('name', name.text);
   await prefs.setString('surname', surname.text);
   await prefs.setString('lastname', lastname.text);
   await prefs.setString('dninie', dninie.text);
   await prefs.setString('phone', phone.text);
   await prefs.setString('alternative', alternative.text);
   await prefs.setString('address', address.text);
   await prefs.setString('postal', postal.text);
   await prefs.setString('urbanization', urbanization.text);
   await prefs.setString('selected_how', _selectedhow ?? '');
   await prefs.setBool('isChecked11', isChecked11);
   await prefs.setBool('isChecked12', isChecked12);

   // Optionally show a success message or navigate to another screen
   Fluttertoast.showToast(
     msg: "Datos guardados exitosamente",
     toastLength: Toast.LENGTH_SHORT,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 1,
     backgroundColor: Colors.black,
     textColor: Colors.white,
     fontSize: 16.0,
   );
 }


 @override
  Widget build(BuildContext context) {

   final List<String> _how = [AppLocalizations.of(context)!.press,AppLocalizations.of(context)!.pressed];
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_back),
          ),
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
                  SizedBox(height: 40,),
                      Center(child: Text(AppLocalizations.of(context)!.account,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                     Text(AppLocalizations.of(context)!.fill,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      // Checkbox(
                      //   activeColor: Colors.blue,
                      //   value: isChecked,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       isChecked = value!;
                      //     });
                      //   },
                      // ),
                     InkWell(
                       onTap: (){
                         setState(() {
                           isChecked21 = !isChecked21;
                           if (!isChecked21) {
                             company.clear(); // Clear the company name
                             cif.clear();     // Clear the CIF
                           }
                         });
                       },
                       child: isChecked21
                           ? Icon(Icons.check_box, color: Colors.blue)
                           : Icon(Icons.check_box_outline_blank_outlined,),
                     ),
                      SizedBox(width: 5,),
                      Text(AppLocalizations.of(context)!.company,style: smallText,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  if (isChecked21) ...[
                    Text(AppLocalizations.of(context)!.companyName,style: smallText,),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: company,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    if (isChecked21)
                      Text(AppLocalizations.of(context)!.cif,style: smallText,),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: cif,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)
                          )
                      ),
                    ),
                  ],
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.name,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)
                      )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.surname,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: surname,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a surname';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.lastName,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.dni,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: dninie,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a DNI/NIE';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.phone,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: phone,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(10), // Restrict input to 10 characters
                    //   FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    // ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.tele,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: alternative,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(10), // Restrict input to 10 characters
                    //   FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    // ],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.address,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                 Text(AppLocalizations.of(context)!.postalCode,style: smallText,),
                  TextField(
                    readOnly: true,
                    controller:postal ,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)
                      ),
                      //suffixIcon: Icon(Icons.arrow_drop_down_sharp)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(AppLocalizations.of(context)!.urbanization,style: smallText,),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: urbanization,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                    onSaved: (val) {
                      //  phone = val;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a urbanization';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(height: 10,),
                  // Text(AppLocalizations.of(context)!.how,style: smallText,),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       border: Border.all(color: Colors.black)
                  //   ),
                  //   // width: 330,
                  //   child: DropdownButton<String>(
                  //     value: _selectedhow,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _selectedhow = value;
                  //       });
                  //       debugPrint("You selected $_selectedhow");
                  //     },
                  //     hint: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         AppLocalizations.of(context)!.press,
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ),
                  //     // Hide the default underline
                  //     underline: Container(),
                  //     // set the color of the dropdown menu
                  //     dropdownColor: Colors.white,
                  //     icon: Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: const Icon(
                  //         Icons.arrow_drop_down_sharp,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     isExpanded: true,
                  //
                  //     // The list of options
                  //     items: _how
                  //         .map((e) => DropdownMenuItem(
                  //       value: e,
                  //       child: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text(
                  //           e,
                  //           style: const TextStyle(fontSize: 18),
                  //         ),
                  //       ),
                  //     ))
                  //         .toList(),
                  //
                  //     // Customize the selected item
                  //     selectedItemBuilder: (BuildContext context) => _how
                  //         .map((e) =>
                  //         Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: Text(
                  //             e,
                  //             style: const TextStyle(
                  //                 fontSize: 18,
                  //                 color: Colors.black,
                  //                 fontStyle: FontStyle.italic,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         )
                  //     )
                  //         .toList(),
                  //   ),
                  // ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isChecked11 = !isChecked11;
                          });
                        },
                        child: isChecked11
                            ? Icon(Icons.check_box, color: Colors.blue)
                            : Icon(Icons.check_box_outline_blank_outlined,),
                      ),
                      SizedBox(width: 3,),
                      Expanded(child: Text(AppLocalizations.of(context)!.offers,style: TextStyle(fontSize: 12),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isChecked12 = !isChecked12;
                          });
                        },
                        child: isChecked12
                            ? Icon(Icons.check_box, color: Colors.blue)
                            : Icon(Icons.check_box_outline_blank_outlined,),
                      ),
                      SizedBox(width: 3,),
                      Expanded(child: Text(AppLocalizations.of(context)!.news,style: TextStyle(fontSize: 12),))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('company_name',company.text.toString() ?? '');
                      await prefs.setString('phone',phone.text.toString() ?? '');
                      await prefs.setString('cif',cif.text.toString() ?? '');
                      await prefs.setString('name',name.text.toString() ?? '');
                      await prefs.setString('surname',surname.text.toString() ?? '');
                      await prefs.setString('lastname',lastname.text.toString() ?? '');
                      await prefs.setString('dninie',dninie.text.toString() ?? '');
                      await prefs.setString('alternative',alternative.text.toString() ?? '');
                      await prefs.setString('address',address.text.toString() ?? '');
                      await prefs.setString('postal',postal.text.toString() ?? '');
                      await prefs.setString('urbanization',urbanization.text.toString() ?? '');
                      await prefs.setString('selected_how',_selectedhow.toString() ?? '');
                      // await prefs.setBool('isChecked21',(isChecked21.toString() ?? '') as bool);
                      // await prefs.setBool('isChecked11',(isChecked11.toString() ?? '') as bool);
                      // await prefs.setBool('isChecked12',(isChecked12.toString() ?? '') as bool);

                      if (_signUpFormKey.currentState?.validate() ?? false) {
                        saveFormData();
                        print("company_name: ${company.text}");
                        print("CIF: ${cif.text}");
                        print("Name: ${name.text}");
                        print("Surname: ${surname.text}");
                        print("Second Last Name: ${lastname.text}");
                        print("DNI/NIE: ${dninie.text}");
                        print("Phone: ${phone.text}");
                        print("Alternative Phone: ${alternative.text}");
                        print("Address: ${address.text}");
                        print("Postal Code: ${postal.text}");
                        print("Urbanization: ${urbanization.text}");
                        print("How did you know us?: $_selectedhow");
                        print("Checkbox 21: $isChecked21");
                        print("Checkbox 11: $isChecked11");
                        print("Checkbox 12: $isChecked12");

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Complete(ids: [],),));
                      } },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Appcolor.purpleColor
                      ),
                      child: Center(child: Text(AppLocalizations.of(context)!.save,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

 Widget _buildDropdown(
     String label,
     List<String> items,
     String? selectedItem,
     ValueChanged<String?> onChanged,
     ) {
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
           border: Border.all(color: Colors.black),
         ),
         child: DropdownButton<String>(
           value: selectedItem,
           onChanged: onChanged,
           hint: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               'Select $label',
               style: const TextStyle(color: Colors.black),
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
                 (e) => DropdownMenuItem<String>(
               value: e,
               child: Container(
                 alignment: Alignment.centerLeft,
                 child: Text(
                   e,
                   style: const TextStyle(fontSize: 18),
                 ),
               ),
             ),
           )
               .toList(),
           selectedItemBuilder: (BuildContext context) => items
               .map(
                 (e) => Padding(
               padding: const EdgeInsets.all(12.0),
               child: Text(
                 e,
                 style: const TextStyle(
                   fontSize: 18,
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

}
