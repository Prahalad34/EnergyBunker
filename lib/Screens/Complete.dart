import 'dart:convert';
import 'package:EnergyBunker/Constants/Discount.dart';
import 'package:EnergyBunker/Screens/Login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:EnergyBunker/Screens/Homescreen.dart';
import 'package:EnergyBunker/Screens/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Appcolor.dart';
class Complete extends StatefulWidget {
  final List<String> ids;

  Complete({required this.ids});

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {


 // TextEditingController company = TextEditingController();

  TextStyle basicText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);

  String dropdownValue = 'A';

  bool _isShown = true;

  TextEditingController Observations = TextEditingController();

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.dear,
              textAlign: TextAlign.center,),
            content:  Text(
              AppLocalizations.of(context)!.email,textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    // Close the dialog
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Service(),));
                  },
                  child: Center(
                    child: Container(
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue
                        ),
                        child: Center(child:  Text(
                          AppLocalizations.of(context)!.room,
                          style: TextStyle(color: Colors.white),textAlign: TextAlign.center,))),
                  )),
            ],
          );
        });
  }


  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;

  String? _selectedtype;
  // final List<String> _product = [AppLocalizations.of(context)!.cash, AppLocalizations.of(context)!.online];

  // the selected value
  String? _selectedproduct;

  late bool isChecked21;
  late String selectcompany;
  late String cif;
  late String name;
  late String surname;
  late String lastname;
  late String dninie;
  late String phone;
  late String alternative;
   String? address;
  late String postal;
  late String urbanization;
  late String selectedHow;
  late bool isChecked11;
  late bool isChecked12;
  String selectedId = '';
  String selectedQuantity = '';
  String selectedTotalAmount = '';
  String userId = '';
 // String selectedmorning = '';
  String selecteddate = '';
  String selectedproductid = '';
  String selectproduct = '';
  String selectsift = '';

 // late String selectedQuantity; // Set this from another screen
//  late String selectedTotalAmount; // Set this from another screen


  Discount? discount;


  @override
  void initState() {
    super.initState();
    _loadData();
    someFunctionThatCallsFetch();

  }


  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
     setState(() {
       isChecked21 = prefs.getBool('isChecked21') ?? false;
       selectcompany = prefs.getString('company_name') ?? '';
       cif = prefs.getString('cif') ?? '';
       name = prefs.getString('name') ?? '';
       surname = prefs.getString('surname') ?? '';
       lastname = prefs.getString('lastname') ?? '';
       dninie = prefs.getString('dninie') ?? '';
       phone = prefs.getString('phone') ?? '';
       alternative = prefs.getString('alternative') ?? '';
       address = prefs.getString('address') ?? '';
       postal = prefs.getString('postal') ?? '';
       urbanization = prefs.getString('urbanization') ?? '';
       selectedHow = prefs.getString('selected_how') ?? '';
       isChecked11 = prefs.getBool('isChecked11') ?? false;
       isChecked12 = prefs.getBool('isChecked12') ?? false;
       selectedId = prefs.getString('selected_id') ?? '';
       selectedQuantity = prefs.getString('selected_quantity') ?? '';
       selectedTotalAmount = prefs.getString('selected_total_amount') ?? '';
      // selectedmorning = prefs.getString('selected_morning') ?? '';
       selecteddate = prefs.getString('selected_date') ?? '';
       selectedproductid = prefs.getString('selected_product_id') ?? '';
       userId = prefs.getString('user_id') ?? 'N/A';
       selectproduct = prefs.getString('selected_product') ?? '';
       selectsift = prefs.getString('selected_shift') ?? '';
       _selectedtype = prefs.getString('postal_code');
     });
    print("selected_product_id: $selectedproductid");
    print("selected_id: $selectedId");
    print("User ID: $userId");
    print("company_name: $selectcompany");
    print("Select product: $selectproduct");
    print("phone: $phone");
    print("Sift: $selectsift");
    print("postal: $postal");
    print("lastname: $lastname");
    print('postal_code: $_selectedtype');
    print('selectedQuantity: $selectedQuantity');
    print('selectedTotalAmount: $selectedTotalAmount');


  }

  // void retrieveSelectedItemData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     selectedId = prefs.getString('selected_id') ?? '';
  //     selectedQuantity = prefs.getString('selected_quantity') ?? '';
  //     selectedTotalAmount = prefs.getString('selected_total_amount') ?? '';
  //     selectedmorning = prefs.getString('selected_morning') ?? '';
  //     selecteddate = prefs.getString('selected_date') ?? '';
  //     selectedproductid = prefs.getString('selected_product_id') ?? '';
  //   });
  //   print("selected_id: $selectedId");
  //   print("selected_quantity: $selectedQuantity");
  //   print("selected_total_amount: $selectedTotalAmount");
  //   print("selected_morning: $selectedmorning");
  //   print("selected_date: $selecteddate");
  //   print("selected_product_id: $selectedproductid");
  // }
  // Future<void> getUserData() async {
  //   // Get the SharedPreferences instance
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Retrieve values from SharedPreferences
  //   setState(() {
  //     userId = prefs.getString('user_id') ?? 'N/A';
  //   });
  //   print("User ID: $userId");
  // }

  String checkboxValue7 = 'No';
  String checkboxValue =  'No';
  String checkboxValue1 = 'No';
  String checkboxValue2 = 'No';
  String checkboxValue3 = 'No';
  String checkboxValue4 = 'No';
  String checkboxValue5 = 'No';
  String checkboxValue6 = 'No';

  bool _isLoading = false;
  String _selectedValue = '1';

  @override
  Widget build(BuildContext context) {

    final List<String> _product = [AppLocalizations.of(context)!.cash, AppLocalizations.of(context)!.online];

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(""),
        leading: IconButton(onPressed: () { 
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back),
          
        ),
        actions: [
      PopupMenuButton<String>(
     icon: CircleAvatar(
       radius: 25,
         backgroundColor: Colors.black,
         child: Icon(Icons.power_settings_new_sharp,color: Colors.white,)),
      onSelected: (String value) {
    setState(() {
    _selectedValue = value;
    });
    },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: '1',
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
            },
              child: Text(AppLocalizations.of(context)!.logOut)),
        ),
        PopupMenuItem(
          value: '2',
          child: InkWell(
                 onTap: () async {
          // Show confirmation dialog
          bool? confirmDelete = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm Deletion'),
                content: Text('Are you sure you want to delete your account?'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Cancel deletion
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm deletion
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );

          // If user confirmed deletion
          if (confirmDelete == true) {
            try {
              await deleteAccount(userId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted successfully'),
                ),
              );
              // Navigate back or to another screen
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to delete account: $e'),
                ),
              );
            }
          }
        },
              child: Text(AppLocalizations.of(context)!.delete, style: TextStyle(color: Colors.red))),
        ),
        ],
      ),
      ]
    ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20,),
                Text(
                  AppLocalizations.of(context)!.page,
                  style: smallText,),
                SizedBox(height: 10,),
                Text(AppLocalizations.of(context)!.order, style: basicText,),
                SizedBox(height: 10,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.product,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(text: selectproduct , style: TextStyle(fontSize: 12,
                          color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.liters,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(text: selectedQuantity ?? "" + 'l', style: TextStyle(
                          fontSize: 12, color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.totalamount,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(text: selectedTotalAmount, style: TextStyle(fontSize: 12,
                          color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.desiscount,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(text: discount != null ? discount!.discount ?? "" : "N/A",  style: TextStyle(fontSize: 12,
                          color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.afterdiscountamount,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan( text: discount != null ? discount!.afterDiscount ?? "" : "N/A", style: TextStyle(fontSize: 12,
                          color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.delivery, style: basicText,),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.shift,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(text: selectsift, style: TextStyle(fontSize: 12,
                          color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 5,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.date,
                    style: smallText,
                    children: <TextSpan>[
                      TextSpan(
                          text: selecteddate, style: TextStyle(
                          fontSize: 12, color: Colors.grey)),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.address, style: basicText,),
                SizedBox(height: 5,),
                Text(AppLocalizations.of(context)!.select, style: smallText,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked7 = !isChecked7;
                          checkboxValue7 = isChecked7 ? 'Yes' : 'No';
                          print("gualavi street (08292) Esparreguera Checkbox value: $checkboxValue7");
                        });
                      },
                      child: isChecked7
                          ? Icon(Icons.radio_button_checked, color: Colors.blue)
                          : Icon(Icons.radio_button_off,),
                    ),
                    SizedBox(width: 3),
                    Text('$address'),
                  ],
                ),
                SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.biling, style: basicText,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                          checkboxValue = isChecked ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue");
                        });
                      },
                      child: isChecked
                          ? Icon(Icons.check_box,color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Text(AppLocalizations.of(context)!.billingAddress, style: smallText,),
                  ],
                ),
                Text('$address'),
                SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.free, style: basicText,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked1 = !isChecked1;
                          checkboxValue1 = isChecked1 ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue1");
                        });
                      },
                      child: isChecked1
                          ? Icon(Icons.check_box, color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Expanded(child: Text(AppLocalizations.of(context)!.need)),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked2 = !isChecked2;
                          checkboxValue2 = isChecked2 ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue2");
                        });
                      },
                      child: isChecked2
                          ? Icon(Icons.check_box, color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Text(AppLocalizations.of(context)!.special),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked3 = !isChecked3;
                          checkboxValue3 = isChecked3 ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue3");
                        });
                      },
                      child: isChecked3
                          ? Icon(Icons.check_box, color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Text(AppLocalizations.of(context)!.notice),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked5 = !isChecked5;
                          checkboxValue5 = isChecked5 ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue5");
                        });
                      },
                      child: isChecked5
                          ? Icon(Icons.check_box, color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Expanded(child: Text(
                      AppLocalizations.of(context)!.small,
                      style: TextStyle(),)),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked6 = !isChecked6;
                          checkboxValue6 = isChecked6 ? 'Yes' : 'No';
                          print("Checkbox value: $checkboxValue6");
                        });
                      },
                      child: isChecked6
                          ? Icon(Icons.check_box, color: Colors.blue)
                          : Icon(Icons.check_box_outline_blank_outlined,),
                    ),
                    SizedBox(width: 3,),
                    Expanded(child: Text(AppLocalizations.of(context)!.truck,
                      style: TextStyle(),)),
                  ],
                ),
              SizedBox(height: 5,),
              Row(
                children: [
                  InkWell(
                          onTap: () {
                            setState(() {
                              isChecked4 = !isChecked4;
                              checkboxValue4 = isChecked4 ? 'Yes' : 'No';
                              print("Checkbox value: $checkboxValue4");
                            });
                          },
                          child: isChecked4
                              ? Icon(Icons.check_box, color: Colors.blue)
                              : Icon(Icons.check_box_outline_blank_outlined,),
                        ),
                        SizedBox(width: 3,),
                  Expanded(child: Text(AppLocalizations.of(context)!.notice)),
                ],
              ),
              //  SizedBox(height: 20,),
                // Text(AppLocalizations.of(context)!.service,
                //   style: basicText,),
                // SizedBox(height: 5,),
                // Text(AppLocalizations.of(context)!.most),
                // SizedBox(height: 15,),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           isChecked4 = !isChecked4;
                //           checkboxValue4 = isChecked4 ? 'Yes' : 'No';
                //           print("Checkbox value: $checkboxValue4");
                //         });
                //       },
                //       child: isChecked4
                //           ? Icon(Icons.check_box, color: Colors.blue)
                //           : Icon(Icons.check_box_outline_blank_outlined,),
                //     ),
                //     SizedBox(width: 3,),
                //     Text(AppLocalizations.of(context)!.discharge),
                //   ],
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           isChecked5 = !isChecked5;
                //           checkboxValue5 = isChecked5 ? 'Yes' : 'No';
                //           print("Checkbox value: $checkboxValue5");
                //         });
                //       },
                //       child: isChecked5
                //           ? Icon(Icons.check_box, color: Colors.blue)
                //           : Icon(Icons.check_box_outline_blank_outlined,),
                //     ),
                //     SizedBox(width: 3,),
                //     Expanded(child: Text(
                //       AppLocalizations.of(context)!.small,
                //       style: TextStyle(),)),
                //   ],
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           isChecked6 = !isChecked6;
                //           checkboxValue6 = isChecked6 ? 'Yes' : 'No';
                //           print("Checkbox value: $checkboxValue6");
                //         });
                //       },
                //       child: isChecked6
                //           ? Icon(Icons.check_box, color: Colors.blue)
                //           : Icon(Icons.check_box_outline_blank_outlined,),
                //     ),
                //     SizedBox(width: 3,),
                //     Expanded(child: Text(AppLocalizations.of(context)!.truck,
                //       style: TextStyle(),)),
                //   ],
                // ),
                 SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.method,
                  style: basicText,),
                SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)
                  ),
                  // width: 330,
                  child: DropdownButton<String>(
                    value: _selectedproduct,
                    onChanged: (value) {
                      setState(() {
                        _selectedproduct = value;
                      });
                      debugPrint("You selected $_selectedproduct");
                    },
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.online,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Hide the default underline
                    underline: Container(),
                    // set the color of the dropdown menu
                    dropdownColor: Colors.white,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.black,
                      ),
                    ),
                    isExpanded: true,

                    // The list of options
                    items: _product
                        .map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ))
                        .toList(),

                    // Customize the selected item
                    selectedItemBuilder: (BuildContext context) =>
                        _product
                            .map((e) =>
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                        )
                            .toList(),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  AppLocalizations.of(context)!.responsible,
                  style: basicText,),
                SizedBox(height: 5,),
                TextField(
                  controller: Observations,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)
                      ),
                      hintText: AppLocalizations.of(context)!.write
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                    AppLocalizations.of(context)!.have),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Homescreen(),));
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue
                        ),
                        child: Center(child: Text(AppLocalizations.of(context)!.again,textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.white),),),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (checkboxValue.isEmpty || !isChecked7 || !isChecked ) {
                          Fluttertoast.showToast(
                            msg: "Por favor seleccione direcciones",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        setState(() {
                          SVProgressHUD.show(); // Show loading indicator
                        });

                        // Wait for the API call to finish
                        await _postData();

                        // Check if either checkbox is not checked
                         if(_isShown){
                           _delete(context);
                         }
                        setState(() {
                          SVProgressHUD.dismiss(); // Dismiss loading indicator
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Appcolor.purpleColor
                        ),
                        child: Center(child: _isLoading ? CircularProgressIndicator(color: Colors.white,strokeWidth: 3,):
                        Center(
                          child: Text(AppLocalizations.of(context)!.confirm,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.white),textAlign: TextAlign.center,),
                        ),),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }


  Future<void> someFunctionThatCallsFetch() async {
    // Set selectedQuantity and selectedTotalAmount
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    selectedQuantity = prefs.getString('selected_quantity') ?? ''; // Updated key
    selectedTotalAmount = prefs.getString('selected_total_amount') ?? ''; // Updated key


    print('Before calling fetchDiscountDetails:');
    print('Selected Quantity: $selectedQuantity');
    print('Selected Total Amount: $selectedTotalAmount');

    // Now call the fetchDiscountDetails function
    await fetchDiscountDetails();
  }


  Future<void> fetchDiscountDetails() async {
    print('fetchDiscountDetails called');

    // Remove commas and ensure they are strings
    String formattedQuantity = selectedQuantity.replaceAll(',', '');
    String formattedTotalAmount = selectedTotalAmount.replaceAll(',', '');

    // if (formattedQuantity.isEmpty || formattedTotalAmount.isEmpty) {
    //   print('Quantity or Total Amount is empty. Please set them before making the API call.');
    //   return;
    // }

    print('Selected Quantity: $formattedQuantity');
    print('Selected Total Amount: $formattedTotalAmount');

    final String apiUrl = 'https://techimmense.in/EnergyBunker/webservice/apply_offer?type=Petrol&total_quantity=${Uri.encodeComponent(formattedQuantity)}&total_amount=${Uri.encodeComponent(formattedTotalAmount)}';
    print('API URL: $apiUrl');
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        print('Response JSON: $json');
        setState(() {
          discount = Discount.fromJson(json);
        });
        // Log the discount details
        print("Total Amount: ${discount?.totalAmount}");
        print("Discount: ${discount?.discount}");
        print("After Discount: ${discount?.afterDiscount}");
        print("Result: ${discount?.result}");
        print("Message: ${discount?.message}");
        print("Status: ${discount?.status}");

      } else {
        print('Failed to load discount data, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching discount details: $e');
    }
  }

  Future<void> _postData() async {
    if (Observations.text.isEmpty
    ) {

      return;
    }
    Map<String, String> paramdata = {
      // "isChecked21": isChecked21.toString(),
      "company_name": selectcompany,
      "cif": cif,
      "first_name": name,
      "middle_name": surname,
      "last_name": lastname,
      "dni_nie": dninie,
      "phone_number": phone,
      "alternative_number": alternative,
      "address": address!,
      "postal_code": postal,
      "urbanization": urbanization,
      "did_know_status": selectedHow,
      // "isChecked12": isChecked12.toString(),
     // "isChecked11": isChecked11.toString(),
      "longer": checkboxValue1,
      "billing_address": checkboxValue,
      "special": checkboxValue2,
      "receive": checkboxValue3,
      "discharge": checkboxValue4,
      "small_truck": checkboxValue5,
      "small_truck1": checkboxValue6,
      "payement": _selectedproduct!,
      "observations": Observations.text,
      "gualavi_street": isChecked7 ? 'Yes' : 'No',
      "product_id": selectedproductid,
      "total_quantity": selectedQuantity,
      "total_amount": discount?.afterDiscount ?? "0",
      // Include discount-related data
     // "before_discount_amount": selectedTotalAmount, // Original amount before discount
      "discount": discount?.discount ?? "0", // Discount amount
      "before_discount_amount": selectedTotalAmount, // Amount after discount
      "user_id": userId,
      "shift_type": selectsift,
      "it_is_company": isChecked21 ? 'Yes' : 'No',
      "receive_offers_and_information_about_the_best_prices": isChecked11 ? 'Yes' : 'No',
      "receive_advertising_news_and_newsletters": isChecked12 ? 'Yes' : 'No',
    };

    print(paramdata);

    setState(() {
      _isLoading = true;
    });


    try {
      final response = await http.post(
        Uri.parse('https://techimmense.in/EnergyBunker/webservice/add_user_request'),

        body: paramdata,
      );
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var Data = jsonDecode(response.body);
        print(Data['message']);
        print(Data);
        print(Data['status']);
        print("Add User successful");
        Fluttertoast.showToast(
          msg: "Agregar usuario exitosa",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Map<String, dynamic>? item = getItemById("1"); // Replace "1" with the actual ID you want to fetch
        // if (item != null) {
        //   await sendDataToServer(item);
        // } else {
        //   print("Item not found");
        // }


      } else {
        print("Registration failed with status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> deleteAccount(String userId) async {
    final url = Uri.parse(
        'https://techimmense.in/EnergyBunker/webservice/delete_account/$userId');
    print(url);

    final response = await http.delete(
        url);

    if (response.statusCode == 200) {
      print('Account deleted successfully');
      // Handle success
    } else {
      throw Exception('Failed to delete account');
      // Handle error
    }
  }
  
  
}