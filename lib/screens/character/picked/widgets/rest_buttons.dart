import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestButtons extends StatelessWidget {
  const RestButtons({
    required this.fileHandler,
    required this.char,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final Character char;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: AppColors.background,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        CustomIcons.hourglass_end,
                        size: 32,
                      ),
                    ),
                  ),
                  const Text('Short rest')
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
                    char.resources[i].remainingUses = char.resources[i].maxUses;
                  }
                }
                await fileHandler.writeChar(char);
                context.read<CharacterCubit>().pickCharacter(char, fileHandler);
              },
            ),
            InkWell(
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: AppColors.background,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Icon(
                          CustomIcons.campground,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const Text('Long rest')
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
                  char.resources[i].remainingUses = char.resources[i].maxUses;
                }
                char.currentHp = char.hp;
                await fileHandler.writeChar(char);
                context.read<CharacterCubit>().pickCharacter(char, fileHandler);
              },
            )
          ],
        ),
      );
}
