import 'package:dnd_helper/screens/character/not_picked/char_list.dart';
import 'package:dnd_helper/screens/rules/rule_sections.dart';
import 'package:dnd_helper/screens/spells/spell_list.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/custom_icons.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;

  var screens = const [
    SpellsPage(),
    CharacterPage(),
    RulesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return PopScope(
      canPop: currentIndex == 1,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          setState(() {
            currentIndex = 1;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.magic,
                size: 28,
              ),
              label: 'Spells',
              backgroundColor: AppColors.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.person,
                size: 28,
              ),
              label: 'Character',
              backgroundColor: AppColors.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.book_1,
                size: 28,
              ),
              label: 'Rules',
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
