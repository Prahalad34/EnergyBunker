import 'dart:convert';
import 'package:EnergyBunker/Screens/Account.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Appcolor.dart';
import 'Service.dart';

class Home extends StatefulWidget {

  final ServiceData? serviceData;

  Home({Key? key, this.serviceData}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  late String postalCodeId;
  late String productType;
  late String quantity;

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
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);
  final List<Color> colors = [
    Colors.white,
    Colors.blue,
    Colors.blue,
    Colors.white,
    Colors.white,
    Colors.blue,
    Colors.blue,

  ];

  String resultMessage = '';
  List<dynamic> result = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back)),
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
                SizedBox(height: 20,),
                  Text('You are seeing the prices with VAT and transportation included that correspond to the liter range of:',style: basicText,textAlign: TextAlign.center,),
                SizedBox(height: 20,),
            Container(
              height: 50,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Center(child: Text('1000 a 1249',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
            ),
             SizedBox(height: 20,),
            SizedBox(
              height: 810, // Adjust the height as needed to fit both lists
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final item = result[index];
                  final color = (item['morning'] == 'Yes' && item['afternoon'] == 'Yes') ? Colors.blue : Colors.white;
                  // if (item['morning'] == 'No' && item['afternoon'] == 'No') {
                  //   // Skip items where both morning and afternoon are "No"
                  //   return SizedBox.shrink();
                  // }
                  return Column(
                    children: [
                      Container(
                        height: 310,
                        width: 200,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                          color:  (item['morning'] == 'Yes') ? Appcolor.purpleColor : Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                color: Appcolor.orangeColor,
                              ),
                              child: Center(
                                child: Text(item['date'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Morning\nDelivery',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black),
                            ),
                            SizedBox(height: 5),
                            if (item['morning'] == 'Yes')
                            Text(item['quantity'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black
                                  ),
                            ),
                            SizedBox(height: 5),
                            Text(
                                item['morning'] == 'Yes'
                                    ? 'Yes'
                                    : 'No service',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black),),
                            SizedBox(height: 10),
                            if (item['morning'] == 'Yes')
                            Text(  item['total_amount']?.isNotEmpty ?? false
                                ? '${item['total_amount']}€'
                                : 'N/A',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black),),
                            SizedBox(height: 1),
                            if (item['morning'] == 'Yes')
                            TextButton(
                              onPressed: () async {

                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('selected_id', item['id']?.toString() ?? '');
                                await prefs.setString('selected_quantity', item['quantity']?.toString() ?? '');
                                await prefs.setString('selected_total_amount', item['total_amount']?.toString() ?? '');
                                await prefs.setString('selected_morning', item['morning']?.toString() ?? '');
                                await prefs.setString('selected_date', item['date']?.toString() ?? '');
                                await prefs.setString('selected_product_id', item['product_id']?.toString() ?? '');


                                Navigator.push(context, MaterialPageRoute(builder: (context) => Account(
                                  selectedItem: {
                                    'shift': 'morning',
                                    'item': item
                                  },
                                ),));
                              },
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white)
                                  ),
                                  child: Center(child: Text('Make an order',style: TextStyle(fontWeight: FontWeight.bold,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black),)),
                                ),
                              ),
                            ),
                            SizedBox(height: 1),
                            if (item['morning'] == 'Yes')
                            Center(child: Text('Payement on delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: (item['morning'] == 'Yes') ? Colors.white : Colors.black),)),
                          SizedBox(height: 3,),
                            if (item['morning'] == 'Yes')
                           Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            color: Appcolor.orangeColor,
                          ),
                             child: Center(child: Text( item['exp_date'].isNotEmpty
                                 ? item['exp_date']
                                 : 'N/A',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                        )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 300,
                        width: 200,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                          color:  (item['afternoon'] == 'Yes') ? Appcolor.purpleColor : Colors.white ,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                color:Appcolor.orangeColor,
                              ),
                              child: Center(
                                child: Text(item['date'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                'Afternoon delivery',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 5),
                            if (item['afternoon'] == 'Yes')
                            Text(item['quantity'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black
                              ),
                            ),
                            SizedBox(height: 5),
                            Text( item['afternoon'] == 'Yes'
                                ? 'Yes'
                                : 'No service',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black),),
                            SizedBox(height: 10),
                            if (item['afternoon'] == 'Yes')
                            Text( item['total_amount']?.isNotEmpty ?? false
                  ? '${item['total_amount']}€'
                      : 'N/A',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black),),
                            SizedBox(height: 1),
                            if (item['afternoon'] == 'Yes')
                            TextButton(
                              onPressed: () async {

                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('selected_id', item['id']?.toString() ?? '');
                                await prefs.setString('selected_quantity', item['quantity']?.toString() ?? '');
                                await prefs.setString('selected_total_amount', item['total_amount']?.toString() ?? '');
                                await prefs.setString('selected_afternoon', item['afternoon']?.toString() ?? '');
                                await prefs.setString('selected_date', item['date']?.toString() ?? '');
                                await prefs.setString('selected_product_id', item['product_id']?.toString() ?? '');



                                Navigator.push(context, MaterialPageRoute(builder: (context) => Account(
                                  selectedItem: {
                                    'shift': 'afternoon',
                                    'item': item
                                  },
                                ),));
                              },
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white)
                                  ),
                                  child: Center(child: Text('Make an order',style: TextStyle(fontWeight: FontWeight.bold,color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black),)),
                                ),
                              ),
                            ),
                            SizedBox(height: 1),
                            if (item['afternoon'] == 'Yes')
                            Center(child: Text('Payement on delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: (item['afternoon'] == 'Yes') ? Colors.white : Colors.black),)),
                            SizedBox(height: 6,),
                            if (item['afternoon'] == 'Yes')
                            Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                color: Appcolor.orangeColor,
                              ),
                              child: Center(child: Text( item['exp_date'].isNotEmpty
                                  ? item['exp_date']
                                  : 'N/A',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void getData() async {
    if (postalCodeId.isEmpty || productType.isEmpty || quantity.isEmpty) {
      print('Error: One or more parameters are empty.');
      return;
    }

    var uri =
        "https://techimmense.in/EnergyBunker/webservice/get_product?postal_code_id=${postalCodeId}&product_type=${productType}&quantity=${quantity}";
    print(uri);
    final response = await http.get(Uri.parse(uri));
    debugPrint("Status code is: ${response.statusCode}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData['message']);
      if (jsonData['result'] is List) {
        setState(() async {
          result = jsonData['result']; //// No filtering, include all items

          // Initialize lists for storing extracted data
          String id = jsonData['result'][0]['id'] ?? ''; // Adjust according to actual response structure
          String quantity = jsonData['result'][0]['quantity'] ?? '';
          String totalAmount = jsonData['result'][0]['total_amount'] ?? ''; // Adjust field name as needed
          String morning = jsonData['result'][0]['morning'] ?? '';
          String date = jsonData['result'][0]['date'] ?? '';
          String productid = jsonData['result'][0]['product_id'] ?? '';


          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('id', id);
          await prefs.setString('quantity', quantity);
          await prefs.setString('total_amount', totalAmount);
          await prefs.setString('morning', morning);
          await prefs.setString('date', date);
          await prefs.setString('product_id', productid);

          setState(() {
            resultMessage =
            'Data saved successfully: ID = $id, Quantity = $quantity, Total Amount = $totalAmount, morning = $morning, date = $date product id = $productid';
          });
        });
        debugPrint(result.length.toString());

      } else {
        debugPrint(
            "Failed to load data with status code: ${response.statusCode}");
      }
    }
  }


// ------------------- Get ID -----------------------------//


//   void sendDataToServer(Map<String, dynamic> item) async {
//     var uri = "https://techimmense.in/EnergyBunker/webservice/get_product?";
//     final response = await http.post(
//       Uri.parse(uri),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(item),
//     );
//
//     if (response.statusCode == 200) {
//       debugPrint("Data sent successfully");
//     } else {
//       debugPrint("Failed to send data with status code: ${response.statusCode}");
//     }
//   }
//
//   Map<String, dynamic>? getItemById(String id) {
//     return result.firstWhere((item) => item['id'] == id, orElse: () => null);
//   }

}

  var arrname = ['Grouping completed','€1574','€1574','No Service','No Service','€1574','€1574'];
