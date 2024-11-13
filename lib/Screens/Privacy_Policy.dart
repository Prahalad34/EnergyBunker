import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({super.key});

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {

  String? privacyPolicyContent;

  @override
  void initState() {
    super.initState();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    final url = Uri.parse('https://techimmense.in/EnergyBunker/webservice/get_user_page');
    final response = await http.post(url, body: {'slug': 'terms-of-service'});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print('JSON Response: $jsonResponse');

        if (jsonResponse.containsKey('result')) {
          // Assuming the response has a key 'result' which contains our desired content
          String contentWithHtml = jsonResponse['result']['term_sp'];

          // HTML tags remove karne ke liye regex use karna
          String contentWithoutHtml = contentWithHtml.replaceAll(RegExp(r'<[^>]*>'), '');

          setState(() {
            privacyPolicyContent = contentWithoutHtml;
          });
        } else {
          setState(() {
            privacyPolicyContent = 'Failed to load content';
          });
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        setState(() {
          privacyPolicyContent = 'Failed to parse content';
        });
      }
    } else {
      setState(() {
        privacyPolicyContent = 'Error: ${response.statusCode}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: privacyPolicyContent != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(privacyPolicyContent ?? ''),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}