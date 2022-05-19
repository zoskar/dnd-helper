import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/screens/character/widgets/form/current_hp_form.dart';
import 'package:dnd_helper/utils/custom_icons_icons.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StatusTab extends StatelessWidget {
  StatusTab({
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final _formKey = GlobalKey<FormBuilderState>();

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
              formKey: _formKey, fileHandler: fileHandler, char: char),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        CustomIcons.hourglass_end,
                        size: 32,
                      ),
                      Text('Short rest')
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hold to short rest'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onLongPress: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    await fileHandler.deleteChar(char);
                    for (var i = 0; i < char.resources.length; i++) {
                      if (char.resources[i].onShortRest) {
                        char.resources[i].remainingUses =
                            char.resources[i].maxUses;
                      }
                    }
                    await fileHandler.writeChar(char);
                    context
                        .read<CharacterCubit>()
                        .pickCharacter(char, fileHandler);
                  },
                ),
                InkWell(
                  child: Column(
                    children: const [
                      Icon(
                        CustomIcons.campground,
                        size: 32,
                      ),
                      Text('Long rest')
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hold to long rest'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onLongPress: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    await fileHandler.deleteChar(char);
                    for (var i = 0; i < char.resources.length; i++) {
                      char.resources[i].remainingUses =
                          char.resources[i].maxUses;
                    }
                    char.currentHp = char.hp;
                    await fileHandler.writeChar(char);
                    context
                        .read<CharacterCubit>()
                        .pickCharacter(char, fileHandler);
                  },
                )
              ],
            ),
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
