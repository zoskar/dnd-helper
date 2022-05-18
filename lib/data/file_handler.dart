import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:dnd_helper/data/models.dart';

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

  final Set<Character> _charSet = {};

  Future<void> writeChar(Character character) async {
    _charSet.clear();

    List<Character> chars = await readChars();

    final File fl = await file;
    for (int i = 0; i < chars.length; i++) {
      Character char = chars[i];
      _charSet.add(char);
    }
    _charSet.add(character);

    final charListMap = _charSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(charListMap));
  }

  Future<List<Character>> readChars() async {
    _charSet.clear();
    final File fl = await file;
    if (!fl.existsSync()) return [];
    final content = await fl.readAsString();

    final List<dynamic> jsonData = jsonDecode(content);
    final List<Character> chars = jsonData
        .map(
          (e) => Character.fromJson(e),
        )
        .toList();
    for (int i = 0; i < chars.length; i++) {
      Character char = chars[i];
      _charSet.add(char);
    }
    return chars;
  }

  Future<void> deleteChar(Character char) async {
    List<Character> chars = await readChars();
    _charSet.clear();

    final File fl = await file;
    for (int i = 0; i < chars.length; i++) {
      Character c = chars[i];
      if (c.name == char.name) {
        continue;
      }

      _charSet.add(c);
    }

    final charListMap = _charSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(charListMap));
  }
}
