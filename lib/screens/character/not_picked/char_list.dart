import 'package:dnd_helper/screens/character/picked/char_view.dart';
import 'package:dnd_helper/screens/character/not_picked/char_form.dart';
import 'package:dnd_helper/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

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
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  //fit: BoxFit.fitHeight,
                  opacity: 0.05,
                  image: Image.asset('assets/icons/app_icon_no_back.png').image,
                ),
              ),
              child: Column(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    onPressed: () async {
                      if (names.contains('New character')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('New character already exists'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        Character char = Character(
                          characterClass: 'Druid',
                          hp: 10,
                          currentHp: 10,
                          ac: 10,
                          level: 1,
                          name: 'New character',
                          race: 'Human',
                          resources: const [],
                          savingThrows: const [],
                          skills: const [],
                          stats: const {
                            'STR': 10,
                            'DEX': 10,
                            'CON': 10,
                            'WIS': 10,
                            'INT': 10,
                            'CHA': 10,
                          },
                          subclass: '',
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditChar(
                              character: char,
                              fileHandler: fileHandler,
                              names: names,
                            ),
                          ),
                        );
                      }
                      setState(() {});
                    },
                    child: const Text('New character'),
                  ),
                ],
              ),
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
