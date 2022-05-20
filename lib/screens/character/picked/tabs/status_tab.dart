import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/screens/character/picked/widgets/current_hp_form.dart';
import 'package:dnd_helper/screens/character/picked/widgets/resource_manager.dart';
import 'package:dnd_helper/screens/character/picked/widgets/rest_buttons.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;

  @override
  Widget build(BuildContext context) {
    final Character char = context.read<CharacterCubit>().pickedChar;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'AC: ${char.ac}',
                  style: AppTextStyles.black24,
                ),
                Text(
                  'HP: ${char.currentHp}/${char.hp}',
                  style: AppTextStyles.black24,
                ),
              ],
            ),
          ),
          CurrentHpButtons(
            fileHandler: fileHandler,
            char: char,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: char.resources.length,
              itemBuilder: (context, index) => ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: _getResources(index, char, context),
                  ),
                ),
                subtitle: Text(
                  char.resources[index].name,
                  style: AppTextStyles.black14,
                ),
              ),
            ),
          ),
          RestButtons(fileHandler: fileHandler, char: char),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResoureManager(
                    fileHandler: fileHandler,
                  ),
                ),
              );
            },
            child: const Text('Manage resources'),
          )
        ],
      ),
    );
  }

  List<Widget> _getResources(
    final int index,
    Character char,
    BuildContext context,
  ) {
    List<Widget> list = [];
    for (int i = 0;
        i < char.resources[index].maxUses - char.resources[index].remainingUses;
        i++) {
      list.add(
        InkWell(
          onTap: () async {
            await fileHandler.deleteChar(char);
            char.resources[index].remainingUses += 1;
            await fileHandler.writeChar(char);
            context.read<CharacterCubit>().pickCharacter(char, fileHandler);
          },
          child: const Icon(
            Icons.square_rounded,
            color: Colors.black,
            size: 40,
          ),
        ),
      );
    }
    for (int i = 0; i < char.resources[index].remainingUses; i++) {
      list.add(
        InkWell(
          onTap: () async {
            await fileHandler.deleteChar(char);
            char.resources[index].remainingUses -= 1;
            await fileHandler.writeChar(char);
            context.read<CharacterCubit>().pickCharacter(char, fileHandler);
          },
          child: const Icon(
            Icons.crop_square_rounded,
            color: Colors.black,
            size: 40,
          ),
        ),
      );
    }

    return list;
  }
}
