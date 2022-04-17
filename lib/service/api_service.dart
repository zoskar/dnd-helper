import 'dart:convert';
import 'package:dnd_helper/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> getSpellsData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells'));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
    }
  }
}
