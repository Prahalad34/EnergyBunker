import 'dart:convert';
import 'package:EnergyBunker/Screens/Discount_Screen.dart';
import 'package:EnergyBunker/Screens/Homescreen.dart';
import 'package:EnergyBunker/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Appcolor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// Define ServiceData class
class PostalCodeData {
  final String postalCode;
  final String id;

  PostalCodeData({required this.postalCode, required this.id});
}

class ServiceData {
  final String? selectedType;
  final String? selectedProduct;
  final String? selectedLiter;

  ServiceData({
    this.selectedType,
    this.selectedProduct,
    this.selectedLiter,
  });
}

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {


  TextStyle basicText = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Appcolor.blackColor);

  TextStyle smallText = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Appcolor.blackColor);
  bool _isLoading = false;
  List<String> _types = [];
  List<dynamic> result = [];
  List<PostalCodeData> _postalCodeData = [];
  String? _selectedType;
  // final List<String> _product = [
  //   AppLocalizations.of(context)!.automotive,
  //   'Diesel fuel for heating and agricultural use'
  // ];
   String? _selectedProduct;
  final List<String> _liter = [
    '400',
    '450',
    '500',
    '550',
    '600',
    '650',
    '700',
    '750',
    '800',
    '850',
    '900',
    '950',
    '1000',
    '1050',
    '1100',
    '1150',
    '1200',
    '1250',
    '1300',
    '1350',
    '1400',
    '1450',
    '1500',
    '1550',
    '1600',
    '1650',
    '1700',
    '1750',
    '1800',
    '1850',
    '1900',
    '1950',
    '2000',
    '2050',
    '2100',
    '2150',
    '2200',
    '2250',
    '2300',
    '2350',
    '2400',
    '2450',
    '2500'
  ];
  String? _selectedLiter;


  // List<PostalCodeData> _postalCodeData = [];
  PostalCodeData? _selectedPostalCode;


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
        print(_selectedPostalCode);
        List<dynamic> result = data['result'];
        setState(() {
          _postalCodeData = result.map((item) =>
              PostalCodeData(
                id: item['id'],
                postalCode: item['postal_code'],
              )).toList();
          _selectedPostalCode =
          _postalCodeData.isNotEmpty ? _postalCodeData[0] : null;
        });
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


  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    _loadData();
  }

  String _selectedValue = '1';

  Widget _buildDropdown<T>(String label,
      List<T> items,
      T? selectedItem,
      ValueChanged<T?> onChanged,
      String Function(T) displayItem,) {
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
              color: Colors.black,
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
          child: DropdownButton<T>(
            value: selectedItem,
            onChanged: onChanged,
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.selected+ " " +"$label",
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
                  DropdownMenuItem<T>(
                    value: e,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        displayItem(e),
                        style: const TextStyle(fontSize: 14),
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
                          displayItem(e),
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

  String? _select;

  // String? _selectedProduct;
  // String? _selectedLiters;
  //
  // final List<String> postalCodes = ['12345', '67890', '54321']; // Example data
  // final List<String> products = ['Product 1', 'Product 2', 'Product 3']; // Example data
  // final List<String> liters = ['1L', '2L', '5L']; // Example data

  void _showDropdown() async {
    if (_postalCodeData == null) return;

    final PostalCodeData? result = await showModalBottomSheet<PostalCodeData>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _postalCodeData.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_postalCodeData[index].postalCode ?? ''),
              onTap: () {
                Navigator.pop(context, _postalCodeData[index]);
              },
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedPostalCode = result;
        _controller.text = result.postalCode ?? '';
      });
    }
  }

  TextEditingController _controller = TextEditingController();

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('postal', _controller.text);
    await prefs.setString('selected_product', _selectedProduct ?? '');
    await prefs.setString('selected_liter', _selectedLiter ?? '');
    await prefs.setString(
        'selected_postal_code_id', _selectedPostalCode?.id ?? '');
    // prefs.setInt('data',);
  }

  final _formKey = GlobalKey<FormState>();

  String userId = '';

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? 'N/A';
    });
  }

    @override
    Widget build(BuildContext context) {

      final List<String> _product = [


        AppLocalizations.of(context)!.automotive,


        AppLocalizations.of(context)!.agricultural



      ];


      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(""),
              // leading: IconButton(onPressed: () {
              //   Navigator.pop(context);
              // }, icon: Icon(Icons.arrow_back),
              //
              // ),
              actions: [
                PopupMenuButton<String>(
                  icon: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.settings,color: Colors.white,)),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Discount_Screen(),));
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/offer1.png',height: 25,width: 25,),
                              SizedBox(width: 5,),
                              Text(AppLocalizations.of(context)!.discountoffer),
                            ],
                          )),
                    ),
                    PopupMenuItem(
                      value: '2',
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 5,),
                              Text(AppLocalizations.of(context)!.logOut),
                            ],
                          )),
                    ),



                  ],
                ),
              ],
             automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 150),
                      Text(AppLocalizations.of(context)!.postalCode,
                        style: smallText,),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: _showDropdown,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              hintText: AppLocalizations.of(context)!
                                  .postalCode,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a postal code';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildDropdown<String>(
                        AppLocalizations.of(context)!.product,
                        _product,
                        _selectedProduct,
                            (value) {
                          setState(() {
                            _selectedProduct = value;
                          });
                        },
                            (item) => item,
                      ),
                      const SizedBox(height: 15),
                      _buildDropdown<String>(
                        AppLocalizations.of(context)!.liters,
                        _liter,
                        _selectedLiter,
                            (value) {
                          setState(() {
                            _selectedLiter = value;
                          });
                        },
                            (item) => item,
                      ),
                      // SizedBox(height: 10,),
                      // TextFormField(
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.all(7),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(7)
                      //     ),
                      //     suffixIcon: DropdownButtonHideUnderline(
                      //       child: DropdownButton<String>(
                      //         icon: Icon(Icons.arrow_drop_down_outlined),
                      //         items: _product.map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value),
                      //           );
                      //         }).toList(),
                      //         onChanged: (String? newValue) {
                      //           setState(() {
                      //             _selectedProduct = newValue;
                      //           });
                      //         },
                      //         value: _selectedProduct,
                      //       ),
                      //     ),
                      //   ),
                      //  // controller: TextEditingController(text: _selectedProduct),
                      // ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            print('Selected Postal Code: ${_selectedPostalCode
                                ?.postalCode}');
                            print('Selected Product: $_selectedProduct');
                            print('Selected Liter: $_selectedLiter');
                            _saveName();
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    Homescreen(
                                      serviceData: ServiceData(
                                        selectedType: _selectedPostalCode
                                            ?.id,
                                        selectedProduct: _selectedProduct,
                                        selectedLiter: _selectedLiter,
                                      ),
                                    ),
                                ));
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Appcolor.purpleColor,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }

  }

