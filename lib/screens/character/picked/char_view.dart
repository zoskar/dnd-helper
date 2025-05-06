import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/screens/character/picked/tabs/char_tab.dart';
import 'package:dnd_helper/screens/character/picked/tabs/skills_tab.dart';
import 'package:dnd_helper/screens/character/picked/tabs/status_tab.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CharView extends StatefulWidget {
  const CharView({
    required this.fileHandler,
    super.key,
  });

  final FileHandler fileHandler;

  @override
  State<CharView> createState() => _CharViewState();
}

class _CharViewState extends State<CharView> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      text: 'Character',
                    ),
                    Tab(
                      text: 'Skills',
                    ),
                    Tab(
                      text: 'Status',
                    ),
                  ],
                  labelColor: Colors.black,
                  indicatorColor: AppColors.primary,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CharTab(fileHandler: widget.fileHandler),
                      const SkillsTab(),
                      StatusTab(fileHandler: widget.fileHandler),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
