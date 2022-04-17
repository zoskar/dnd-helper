import 'package:dnd_helper/screens/character.dart';
import 'package:dnd_helper/screens/combat.dart';
import 'package:dnd_helper/screens/rules.dart';
import 'package:dnd_helper/screens/spells.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;
  var screens = [
    CharacterPage(),
    CombatPage(),
    SpellsPage(),
    RulesPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: screens[current_index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: current_index,
            onTap: (index) => setState(() => current_index = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'character',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'combat',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'spells',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'rules',
                backgroundColor: Colors.red,
              ),
            ]),
      );
}
