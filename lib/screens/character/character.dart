import 'package:dnd_helper/screens/character/edit_char.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/character_cubit.dart';
import '../../data/file_handler.dart';
import '../../data/models.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final FileHandler fileHandler = FileHandler.instance;

  @override
  Widget build(BuildContext context) {
    context.read<CharacterCubit>().init(fileHandler);

    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterNotPicked) {
          List<Character> charList = context.read<CharacterCubit>().charList;
          return Scaffold(
            body: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    await fileHandler.writeChar(
                      const Character(
                        characterClass: 'Barbarian',
                        hp: 10,
                        ac: 10,
                        level: 1,
                        name: 'Bebok',
                        race: 'human',
                        resources: [],
                        savingThrows: {},
                        skills: {},
                        stats: {},
                        subclass: 'Path of the totem warrior',
                      ),
                    );
                    setState(() {});
                  },
                  child: const Text('Add Bebok'),
                ),
                const Text(
                  'Pick character',
                  style: AppTextStyles.header,
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: charList.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
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
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          ),
                        ),
                        title: SizedBox(
                          height: 40,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<CharacterCubit>()
                                  .pickCharacter(charList[index], fileHandler);
                            },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    charList[index].name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CharacterPicked) {
          return Center(
            child: Column(
              children: [
                Text(
                    'Current character: ${context.read<CharacterCubit>().pickedChar.toString()}'),
                TextButton(
                  child: const Text('Switch character'),
                  onPressed: () {
                    context.read<CharacterCubit>().switchCharacter(fileHandler);
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
