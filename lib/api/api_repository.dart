import 'package:dnd_helper/api/models.dart';

import 'dart:convert';
import 'package:dnd_helper/api/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<List<SpellListItem>?> getSpellListItems(params) async {
    final response = await apiService.getSpellListItemData(params);
    if (response != null) {
      final data = response as Map<String, dynamic>;
      var spells = <SpellListItem>[];

      for (var el in data['results']) {
        spells.add(SpellListItem.fromJson(el));
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

  Future<RuleSection?> getRuleSection(String ruleSectionName) async {
    final response = await apiService.getRuleSectionData(ruleSectionName);
    if (response != null) {
      final json = response as Map<String, dynamic>;
      final ruleSection = RuleSection.fromJson(json);
      return ruleSection;
    } else {
      return null;
    }
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
  Future<dynamic> getSpellListItemData(params) async {
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

  Future<dynamic> getRuleSectionData(String ruleName) async {
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
