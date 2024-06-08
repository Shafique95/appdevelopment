import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../models/contacts_model.dart';

class ApiRepository {
  static const String _baseUrl = "http://192.168.43.71:3001";
  var headers = {
    'Content-Type': 'application/json'
  };
  Future<int> addContact(
      {required String name, required String phoneNumber}) async {
    final url = Uri.parse("$_baseUrl/contacts");
    var bodyMap={
      'name': name,
      'phone': phoneNumber,
    };
    Response response = await http.post(
      url,
      body: jsonEncode(bodyMap),
      headers: headers,
    );

    if(response.statusCode==201){
      return 201;
    }else{
      print(response.body);
      log(response.body);
      throw Exception("Failed to add contact${response.statusCode}");
    }
  }

  Future<List<Contact>> getContacts() async {
    final url = Uri.parse("$_baseUrl/contacts");
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonData = jsonResponse['data'];
      List<Contact> contacts = jsonData.map((json) => Contact.fromJson(json)).toList();
      return contacts;
    } else {
      throw Exception("Failed to load contacts: ${response.reasonPhrase}");
    }
  }
}
