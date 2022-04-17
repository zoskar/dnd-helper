import 'package:dnd_helper/cubit/spells_model.dart';
import 'package:dnd_helper/service/api_service.dart';

class ApiRepository {
  final ApiService apiService;

  ApiRepository(this.apiService);

  Future<dynamic> getPostList() async {
    final response = await apiService.getSpellsData();
    if (response != null) {
      final data = response as Map<String, dynamic>;
      var result = [];

      for (var el in data['results']) {
        result.add(Spells(index: el['index'], name: el['name'], url: el['url']));
      }

      return result;
    }
  }
}
