import 'package:dnd_helper/api/spells_model.dart';

import 'dart:convert';
import 'package:dnd_helper/api/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<dynamic> getSpellsList() async {
    final response = await apiService.getSpellsData();
    if (response != null) {
      final data = response as Map<String, dynamic>;
      var result = [];

      for (var el in data['results']) {
        result
            .add(Spells(index: el['index'], name: el['name'], url: el['url']));
      }

      return result;
    }
  }
}
class ApiService {
  Future<dynamic> getSpellsData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells$params'));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
    }
  }
}
