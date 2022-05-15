import 'package:dnd_helper/screens/character/char_list.dart';
import 'package:dnd_helper/screens/combat/combat.dart';
import 'package:dnd_helper/screens/rules/rule_sections.dart';
import 'package:dnd_helper/screens/spells/spell_list.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/custom_icons_icons.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  var screens = const [
    CharacterPage(),
    CombatPage(),
    SpellsPage(
      params: '',
    ),
    RulesPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // ignore: use_decorated_box
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.myGradient,
            ),
          ),
          title: const Text(
            'Dnd Helper',
            style: AppTextStyles.appbar,
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.person),
              label: 'Character',
              backgroundColor: AppColors.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.broadsword),
              label: 'Combat',
              backgroundColor: AppColors.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.magic),
              label: 'Spells',
              backgroundColor: AppColors.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.book_1),
              label: 'Rules',
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      );
}
