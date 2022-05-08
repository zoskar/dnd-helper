import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'models.dart';

class FileHandler {
  FileHandler._privateConstructor();
  static final FileHandler instance = FileHandler._privateConstructor();

  static File? _file;

  static const _fileName = 'character_file.txt';

  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
  }

  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    //print('$path/$_fileName');

    return File('$path/$_fileName');
  }

  static Set<Character> _charSet = {};

  Future<void> writeChar(Character character) async {
    final File fl = await file;
    _charSet.add(character);

    final charListMap = _charSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(charListMap));
  }

  Future<List<Character>> readChars() async {
    final File fl = await file;
    if (!fl.existsSync()) return [];
    final content = await fl.readAsString();

    final List<dynamic> jsonData = jsonDecode(content);
    final List<Character> chars = jsonData
        .map(
          (e) => Character.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return chars;
  }

  Future<void> deleteChar(Character char) async {
    final File fl = await file;
    _charSet.removeWhere((e) => e.name == char.name);
    final charListMap = _charSet.map((e) => e.toJson()).toList();
    await fl.writeAsString(jsonEncode(charListMap));
  }

  Future<void> updateChar({
    required Character updatedChar,
  }) async {
    _charSet.removeWhere((e) => e.name == updatedChar.name);
    await writeChar(updatedChar);
  }
}
