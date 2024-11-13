import 'dart:convert';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Constants/Appcolor.dart';
import '../Constants/language_provider.dart';
import 'Account.dart';
import 'Service.dart';
class Homescreen extends StatefulWidget {
  final ServiceData? serviceData;
  const Homescreen({super.key, this.serviceData});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  late String postalCodeId;
  late String productType;
  late String quantity;
  List<dynamic> result = [];  // Use List<dynamic> to match API response
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    // Extract values from serviceData
    postalCodeId = widget.serviceData?.selectedType ?? '';
    productType = widget.serviceData?.selectedProduct ?? '';
    quantity = widget.serviceData?.selectedLiter ?? '';
    getData();
  }

  TextStyle basicText = TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    color: Appcolor.blackColor,
  );

  TextStyle smallText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Appcolor.blackColor,

  );

  // final Map<String, dynamic> item = {
  //   "id": "1",
  //   "day": "1",
  //   "date": "2024-10-02",
  //   "day_name": "Oct 02 Wednesday",
  //   "day_name_sp": "Oct 02 Miércoles",
  //   "day_name_Cat": "Oct 02 dimecres",
  //   "product_id": "6",
  //   "morning": "Yes",
  //   "afternoon": "Yes",
  //   "per_liter_price": "1.21",
  //   "quantity": "1000",
  //   "total_amount": "1,210.00"
  // };

String selectedLocale = '';


  @override
  Widget build(BuildContext context) {

    // Get selected locale from the provider
    // final selectedLocale = context.watch<LanguageProvider>().selectedLocale;
    //
    // // Determine the day name based on the selected locale
    // String dayName;
    // if (selectedLocale == 'es') {
    //   dayName = item['day_name_sp'] ?? 'N/A'; // Spanish
    // } else if (selectedLocale == 'ca') {
    //   dayName = item['day_name_Cat'] ?? 'N/A'; // Catalan
    // } else {
    //   dayName = item['day_name'] ?? 'N/A'; // Default to English
    // }


    return SafeArea(
      child: Scaffold(
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                     AppLocalizations.of(context)!.you,
                    style: basicText,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        '${quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 810, // Adjust height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final item = result[index];
                        final color = (item['morning'] == 'Yes' && item['afternoon'] == 'Yes') ? Colors.blue : Colors.white;

                        return Column(
                          children: [
                            _buildDeliveryCard(
                              item: item,
                              shift: 'morning',
                              color: color,
                              onPressed: () => _handleOrderButtonPress(item, AppLocalizations.of(context)!.morningitem),
                            ),
                            SizedBox(height: 10),
                            _buildDeliveryCard(
                              item: item,
                              shift: 'afternoon',
                              color: color,
                              onPressed: () => _handleOrderButtonPress(item, AppLocalizations.of(context)!.afternoonitem),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard({
    required Map<String, dynamic> item,
    required String shift,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: shift == 'morning' ? 320 : 320,
      width: 200,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        color: (item[shift] == 'Yes') ? Appcolor.purpleColor : Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Appcolor.orangeColor,
            ),
            child: Center(
              child: Text(
                (() {
                  String dayName;
                  switch (context.watch<LanguageProvider>().selectedLocale.languageCode) {  // Extract languageCode here
                    case 'es':
                      dayName = item['day_name_sp'] ?? 'N/A'; // Spanish
                      break;
                    case 'ca':
                      dayName = item['day_name_Cat'] ?? 'N/A'; // Catalan
                      break;
                    default:
                      dayName = item['day_name'] ?? 'N/A'; // Default to English
                      break;
                  }
                  print("Selected language: " + context.watch<LanguageProvider>().selectedLocale.languageCode);  // Extract languageCode here
                  return dayName;
                })(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              '${shift == 'morning' ? AppLocalizations.of(context)!.morning : AppLocalizations.of(context)!.afternoon}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: (item[shift] == 'Yes') ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          if (item[shift] == 'Yes')
            Text(
              item['quantity']+'Lts.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        //  SizedBox(height: 5),
          Text(
            item[shift] == 'Yes' ? '' : 'No service',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: (item[shift] == 'Yes') ? Colors.white : Colors.black,
            ),
          ),
          if (item[shift] == 'Yes')
          Text(item['per_liter_price']+'€',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
          SizedBox(height: 10),
          // if (item[shift] == 'Yes')
          //   Text(item['before_discount_amount']?.isNotEmpty ?? false
          //       ? 'BDA:${item['before_discount_amount']}€'
          //       : 'N/A',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 14,
          //       color: Colors.white,
          //     ),
          //   ),
          // SizedBox(height: 8),
          // if (item[shift] == 'Yes')
          //   Text(item['discount_percentage']?.isNotEmpty ?? false
          //       ? 'Percentage:${item['discount_percentage']}%'
          //       : 'N/A',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 14,
          //       color: Colors.white,
          //     ),
          //   ),
          // SizedBox(height: 8),
          // if (item[shift] == 'Yes')
          //   Text(item['discount']?.isNotEmpty ?? false
          //       ? 'discount:${item['discount']}€'
          //       : 'N/A',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 14,
          //       color: Colors.white,
          //     ),
          //   ),
          // SizedBox(height: 8),
          if (item[shift] == 'Yes')
            Text(item['total_amount']?.isNotEmpty ?? false
                  ? 'Total:${item['total_amount']}€'
                  : 'N/A',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          SizedBox(height: 15),
          if (item[shift] == 'Yes')
            TextButton(
              onPressed: onPressed,
              child: Container(
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.make,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          SizedBox(height: 1),
          // if (item[shift] == 'Yes')
          //   Center(
          //     child: Text(
          //       AppLocalizations.of(context)!.payment,textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // SizedBox(height: 3),
          // if (item[shift] == 'Yes')
          //   Container(
          //     height: 40,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(8),
          //         bottomRight: Radius.circular(8),
          //       ),
          //       color: Appcolor.orangeColor,
          //     ),
          //     child: Center(
          //       child: Text(
          //         item['exp_date']?.isNotEmpty ?? false ? item['exp_date'] : 'N/A',
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  void _handleOrderButtonPress(Map<String, dynamic> item, String shift) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_id', item['id']?.toString() ?? '');
    await prefs.setString('selected_quantity', item['quantity']?.toString() ?? '');
    await prefs.setString('selected_total_amount', item['total_amount']?.toString() ?? '');
    await prefs.setString('selected_shift', shift);
    await prefs.setString('selected_date', item['date']?.toString() ?? '');
    await prefs.setString('selected_product_id', item['product_id']?.toString() ?? '');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Account(
          selectedItem: {
            'shift': shift,
            'item': item,
          },
        ),
      ),
    );
  }

  void getData() async {
    SVProgressHUD.show(); // Show loading indicator
    if (postalCodeId.isEmpty || productType.isEmpty || quantity.isEmpty) {
      print('Error: One or more parameters are empty.');
      return;
    }

    final uri =
        "https://techimmense.in/EnergyBunker/webservice/get_product?postal_code_id=${postalCodeId}&product_type=${productType}&quantity=${quantity}";
    print(uri);
    final response = await http.get(Uri.parse(uri));

    debugPrint("Status code is: ${response.statusCode}");
    debugPrint("Response: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      print(jsonData['message']);

      if (jsonData['result'] is List) {
        setState(() {
          result = jsonData['result']; // No filtering, include all items

          // Optionally save data to SharedPreferences
          if (result.isNotEmpty) {
            final item = jsonData['result'][0];
            saveItemToPreferences(item);
          }
        });

        debugPrint(result.length.toString());
      } else {
        debugPrint("Unexpected JSON structure: ${jsonData.runtimeType}");
      }
    } else {
      debugPrint("Failed to load data with status code: ${response.statusCode}");
    }
    SVProgressHUD.dismiss(); // Dismiss loading indicator
  }

  Future<void> saveItemToPreferences(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', item['id'] ?? '');
    await prefs.setString('quantity', item['quantity'] ?? '');
    await prefs.setString('total_amount', item['total_amount'] ?? '');
    await prefs.setString('morning', item['morning'] ?? '');
    await prefs.setString('date', item['date'] ?? '');
    await prefs.setString('product_id', item['product_id'] ?? '');
  }
}

extension StringCapitalize on String {
  String capitalize() {
    if (this == null || this.isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }

}