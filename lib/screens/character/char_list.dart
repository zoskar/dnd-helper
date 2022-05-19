import 'package:dnd_helper/screens/character/char_view.dart';
import 'package:dnd_helper/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dnd_helper/screens/character/char_form.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  CharacterPageState createState() => CharacterPageState();
}

class CharacterPageState extends State<CharacterPage> {
  final FileHandler fileHandler = FileHandler.instance;

  @override
  Widget build(BuildContext context) {
    context.read<CharacterCubit>().init(fileHandler);

    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterNotPicked) {
          List<String> names = [];

          List<Character> charList = context.read<CharacterCubit>().charList;
          double width = MediaQuery.of(context).size.width;
          for (final c in charList) {
            names.add(c.name);
          }
          return Scaffold(
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Pick character',
                    style: AppTextStyles.black24,
                  ),
                ),
                const MyDivider(),
                Flexible(
                  child: ListView.builder(
                    itemCount: charList.length,
                    itemBuilder: (context, index) => ListTile(
                      trailing: SizedBox(
                        height: 40,
                        child: InkWell(
                          child: const Icon(
                            Icons.edit,
                            size: 30,
                            color: AppColors.secondary,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditChar(
                                  character: charList[index],
                                  fileHandler: fileHandler,
                                  names: names,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                      ),
                      title: SizedBox(
                        height: 60,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<CharacterCubit>()
                                .pickCharacter(charList[index], fileHandler);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 1.8,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  charList[index].name,
                                  style: AppTextStyles.black24,
                                ),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '${charList[index].characterClass} lvl '
                                '${charList[index].level}',
                                style: AppTextStyles.black14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (names.contains('New character')) return;
                    await fileHandler.writeChar(
                      Character(
                        characterClass: 'Druid',
                        hp: 10,
                        currentHp: 5,
                        ac: 10,
                        level: 1,
                        name: 'New character',
                        race: '',
                        resources: [
                          Resource(
                            name: 'Action Surge',
                            maxUses: 8,
                            remainingUses: 3,
                            onShortRest: false,
                          ),
                          Resource(
                            name: 'Wild shape',
                            maxUses: 2,
                            remainingUses: 1,
                            onShortRest: true,
                          ),
                        ],
                        savingThrows: const [],
                        skills: const [],
                        stats: const {
                          'STR': 10,
                          'DEX': 10,
                          'CON': 10,
                          'WIS': 10,
                          'INT': 10,
                          'CHA': 10
                        },
                        subclass: '',
                      ),
                    );

                    setState(() {});
                  },
                  child: const Text('New character'),
                ),
              ],
            ),
          );
        } else if (state is CharacterPicked) {
          return CharView(
            fileHandler: fileHandler,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
