import 'package:dnd_helper/screens/character/character.dart';
import 'package:dnd_helper/screens/combat/combat.dart';
import 'package:dnd_helper/screens/rules/rules.dart';
import 'package:dnd_helper/screens/spells/spellList.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 2;

  var screens = const [
    CharacterPage(),
    CombatPage(),
    SpellsPage(params: '',),
    RulesPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'Dnd Helper',
            style: AppTextStyles.h,
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            currentIndex: currentIndex,

            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'character',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'combat',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'spells',
                backgroundColor: AppColors.primary,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'rules',
                backgroundColor: AppColors.primary,
              ),
            ]),
      );
}
