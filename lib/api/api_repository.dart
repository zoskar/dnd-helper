import 'package:dnd_helper/api/models.dart';

import 'dart:convert';
import 'package:dnd_helper/api/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<dynamic> getSpellsList(params) async {
    final response = await apiService.getSpellsData(params);
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

  Future<dynamic> getSpellList(spellName) async {
    final response = await apiService.getSpellData(spellName);
    if (response != null) {
      final data = response as Map<String, dynamic>;
      var result = Spell(
        id: data['_id'],
        desc: data['desc'][0],
        components: data['components'],
        higer_level: data['higher_level'],
        range: data['range'],
        ritual: data['ritual'],
        duration: data['duration'],
        concentration: data['concentration'],
        casting_time: data['casting_time'],
        level: data['level'],
        // heal_at_slot_level: data['heal_at_slot_level'],
        school: data['school'],
        classes: data['classes'],
        subclasses: data['subclasses'],
        // index: data['index'],
        name: data['name'],
        // url: data['url']);
      );
      
      return result;
    }
  }
}

class ApiService {
  Future<dynamic> getSpellsData(params) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells$params'));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> getSpellData(spellIndex) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells/$spellIndex'));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (e) {
      print('Error: $e');
    }
  }
}
