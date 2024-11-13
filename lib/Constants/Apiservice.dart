
import 'dart:convert';

import 'package:http/http.dart' as http;
   class Apiservice {

     final String _url = 'https://techimmense.in/EnergyBunker/webservice/get_user_page';

     Future<Map<String, dynamic>> fetchPrivacyPolicy() async {
       final response = await http.get(Uri.parse(_url));

       if (response.statusCode == 200) {
         return jsonDecode(response.body);
       } else {
         throw Exception('Failed to load data');
       }
     }
   }