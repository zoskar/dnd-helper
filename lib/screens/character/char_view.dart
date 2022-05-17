import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/screens/character/tabs/char_tab.dart';
import 'package:dnd_helper/screens/character/tabs/skills_tab.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharView extends StatefulWidget {
  const CharView({
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;

  @override
  State<CharView> createState() => _CharViewState();
}

class _CharViewState extends State<CharView> {
  @override
  Widget build(BuildContext context) {
    Character char = context.read<CharacterCubit>().pickedChar;

    return DefaultTabController(
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
                    CharTab(char: char, fileHandler: widget.fileHandler),
                    SkillsTab(char: char),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
