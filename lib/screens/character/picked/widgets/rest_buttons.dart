import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestButtons extends StatelessWidget {
  const RestButtons({
    required this.fileHandler,
    required this.char,
    super.key,
  });

  final FileHandler fileHandler;
  final Character char;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.n),
                      shape: WidgetStateProperty.all<CircleBorder>(
                        const CircleBorder(
                            //side: BorderSide(color: Colors.red),
                            ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        CustomIcons.hourglass_end,
                        size: 32,
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hold to short rest'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    onLongPress: () async {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rested'),
                          duration: Duration(seconds: 1),
                        ),
                      );
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
                  const Text('Short rest'),
                ],
              ),
            ),
            InkWell(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.n),
                      shape: WidgetStateProperty.all<CircleBorder>(
                        const CircleBorder(
                            //side: BorderSide(color: AppColors.primary),
                            ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          CustomIcons.campground,
                          size: 32,
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hold to long rest'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                    onLongPress: () async {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rested'),
                          duration: Duration(seconds: 1),
                        ),
                      );
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
                  ),
                  const Text('Long rest'),
                ],
              ),
            ),
          ],
        ),
      );
}
