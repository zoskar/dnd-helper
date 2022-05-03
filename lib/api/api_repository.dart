import 'package:dnd_helper/api/models.dart';

import 'dart:convert';
import 'package:dnd_helper/api/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<List<Spells>?> getSpellsList(params) async {
    final response = await apiService.getSpellsData(params);
    if (response != null) {
      final data = response as Map<String, dynamic>;
      var spells = <Spells>[];

      for (var el in data['results']) {
        spells.add(Spells.fromJson(el));
      }

      return spells;
    }
    return null;
  }

  Future<Spell?> getSpell(spellName) async {
    final response = await apiService.getSpellData(spellName);
    if (response != null) {
      final json = response as Map<String, dynamic>;
      final spell = Spell.fromJson(json);
      return spell;
    }

    return null;
  }

  Future<List<Rules>?> getRules(List<String> rulesList) async {
    List<Rules> rules = [];
    for (var r in rulesList) {
      final response = await apiService.getRulesData(r);
      if (response != null) {
        final json = response as Map<String, dynamic>;
        final ruleSection = Rules.fromJson(json);
        rules.add(ruleSection);
      } else {
        return null;
      }
    }
    return rules;
  }

  Future<Rule?> getRule(ruleURL) async {
    final response = await apiService.getRuleData(ruleURL);
    if (response != null) {
      final json = response as Map<String, dynamic>;
      final rule = Rule.fromJson(json);
      return rule;
    } else {
      return null;
    }
  }
}

class ApiService {
  Future<dynamic> getSpellsData(params) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells$params'));
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> getSpellData(spellIndex) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$spells/$spellIndex'));
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> getRulesData(String ruleName) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$rules/$ruleName'));
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> getRuleData(ruleURL) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$ruleURL'));
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
