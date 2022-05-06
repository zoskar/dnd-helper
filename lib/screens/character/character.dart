import 'package:flutter/material.dart';

import '../../data/file_handler.dart';
import '../../data/models.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final FileHandler fileHandler = FileHandler.instance;
  List<Character> charList = [];

  final Character char1 = const Character(
    characterClass: 'barbarian',
    hp: 10,
    level: 1,
    name: 'Bruneor',
    race: 'human',
    resources: [],
    savingThrows: {},
    skills: {},
    stats: {},
    subclass: '',
    temporaryHp: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final _users = await fileHandler.readChars();
                    setState(() {
                      charList = _users;
                    });
                  },
                  child: Text('Get Users'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await fileHandler.writeChar(char1);
                  },
                  child: Text('Insert Users'),
                ),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    Character _charUpdate = const Character(
                      characterClass: 'barbarian',
                      hp: 10,
                      level: 2,
                      name: 'Bruneor',
                      race: 'human',
                      resources: ['resource'],
                      savingThrows: {'STR': 1},
                      skills: {},
                      stats: {},
                      subclass: '',
                      temporaryHp: 1,
                    );

                    await fileHandler.updateChar(updatedChar: _charUpdate);
                  },
                  child: Text('Update User'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await fileHandler.deleteChar(char1);
                  },
                  child: Text('Delete User'),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: charList.map((e) => Text(e.toString())).toList(),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
