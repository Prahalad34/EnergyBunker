import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:EnergyBunker/Constants/Appcolor.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class Discount_Screen extends StatefulWidget {
  const Discount_Screen({super.key});

  @override
  State<Discount_Screen> createState() => _Discount_ScreenState();
}

class _Discount_ScreenState extends State<Discount_Screen> {


  int isActive = 0;


  List<dynamic> apiData = [];
  List<dynamic> apidisle = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDatapetrol();
    fetchDataDiesl();
  }

  // Function to fetch data from API
  Future<void> fetchDatapetrol() async {
    SVProgressHUD.show(); // Show loading indicator
    final response = await http.get(Uri.parse('https://techimmense.in/EnergyBunker/webservice/get_product_discount?type=Petrol'));
   print(response);
    if (response.statusCode == 200) {
      // If the response is a Map (JSON object)
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      // Assuming the actual data list is under a key called "data"
      setState(() {
        apiData = decodedResponse['result'];// Extracting the list from the map
        print(apiData);
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load data');
    }
    SVProgressHUD.dismiss(); // Dismiss loading indicator
  }

  Future<void> fetchDataDiesl() async {
    SVProgressHUD.show(); // Show loading indicator
    final response = await http.get(Uri.parse('https://techimmense.in/EnergyBunker/webservice/get_product_discount?type=Diesel'));

    if (response.statusCode == 200) {
      // If the response is a Map (JSON object)
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      // Assuming the actual data list is under a key called "data"
      setState(() {
        apidisle = decodedResponse['result'];// Extracting the list from the map
        print(apidisle);
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load data');
    }
    SVProgressHUD.dismiss(); // Dismiss loading indicator
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
   appBar: AppBar(
     centerTitle: true,
     title: Text(AppLocalizations.of(context)!.discountappbar,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
     leading: IconButton(
       onPressed: () {
         Navigator.pop(context);
       }, icon: Icon(Icons.arrow_back,size: 30,),

     ),
   ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                   border: Border.all(color: Colors.black)
                   // color: Appcolor.purpleColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              isActive =0;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isActive==0? Appcolor.purpleColor:null
                              ),
                              child: Center(child: Text(AppLocalizations.of(context)!.automot,style: TextStyle(fontWeight: FontWeight.bold,color:isActive==0? Colors.white: Colors.black),))),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              isActive =1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:isActive==1? Appcolor.purpleColor:null
                                ),
                                child: Center(child: Text(AppLocalizations.of(context)!.agricultu,style: TextStyle(fontWeight: FontWeight.bold,color:isActive==1? Colors.white: Colors.black),))),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                isActive==0?
                    Petrol():
                    Diesel()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget Petrol()=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 10,
      ),
      Text(AppLocalizations.of(context)!.automotive,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      SizedBox(
        height: 10,
      ),
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1, // Only one table, change it if needed
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Table(
                  border: TableBorder.all(width: 1, color: Colors.white), // Table border
                  children: [
                    // Static header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Appcolor.orangeColor,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              AppLocalizations.of(context)!.quantity,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.quantityend,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.discountpercent,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),


                    // Dynamic rows based on dataList length
                    for (var data in apiData)
                      TableRow(
                        decoration: BoxDecoration(color: Appcolor.purpleColor),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['limit_start'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['limit_end'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['percentage'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          );
        },
      )
    ],
  );
  Widget Diesel()=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 10,
      ),
      Text(AppLocalizations.of(context)!.agricultural,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      SizedBox(
        height: 10,
      ),
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1, // Only one table, change it if needed
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Table(
                  border: TableBorder.all(width: 1, color: Colors.white), // Table border
                  children: [
                    // Static header row
                    TableRow(
                      decoration: BoxDecoration(
                        color: Appcolor.orangeColor,
                      ),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              AppLocalizations.of(context)!.quantity,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.quantityend,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.discountpercent,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Dynamic rows based on dataList length
                    for (var data in apidisle)
                      TableRow(
                        decoration: BoxDecoration(
                          color: Appcolor.purpleColor,
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['limit_start'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['limit_end'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  data['percentage'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          );
        },
      )
    ],
  );

}
