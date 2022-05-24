import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharTab extends StatelessWidget {
  const CharTab({
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final double _buttonHeight = 4;
  final double _buttonWidth = 8;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final Character char = context.read<CharacterCubit>().pickedChar;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                context.read<CharacterCubit>().switchCharacter(fileHandler);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppColors.n,
              ),
              width: width,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                char.name,
                style: AppTextStyles.black44,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: _buttonHeight,
                      bottom: _buttonHeight,
                      left: _buttonWidth,
                      right: _buttonWidth,
                    ),
                    child: Text(
                      char.race,
                      style: AppTextStyles.black18,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: _buttonHeight,
                      bottom: _buttonHeight,
                      left: _buttonWidth,
                      right: _buttonWidth,
                    ),
                    child: Text(
                      char.characterClass,
                      style: AppTextStyles.black18,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: _buttonHeight,
                      bottom: _buttonHeight,
                      left: _buttonWidth,
                      right: _buttonWidth,
                    ),
                    child: Text(
                      'Level ${char.level}',
                      style: AppTextStyles.black18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                    color: AppColors.background,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: _buttonHeight,
                  bottom: _buttonHeight,
                  left: _buttonWidth,
                  right: _buttonWidth,
                ),
                child: Text(
                  char.subclass,
                      style: AppTextStyles.black18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Max HP: ${char.hp}',
                  style: AppTextStyles.black28,
                ),
                Text(
                  'AC: ${char.ac}',
                  style: AppTextStyles.black28,
                ),
              ],
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            //childAspectRatio: 1.0,
            crossAxisCount: 3,
            shrinkWrap: true,
            children: stats
                .map(
                  (stat) => Card(
                    color: AppColors.n,
                    shadowColor: AppColors.secondary,
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 4),
                          child: Text(
                            stat,
                            style: AppTextStyles.black16,
                          ),
                        ),
                        Text(
                          char.stats[stat].toString(),
                          style: AppTextStyles.black44,
                        ),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          alignment: Alignment.center,
                          height: 16,
                          width: 40,
                          child: Text(
                            int.parse(char.stats[stat].toString()) - 10 > 0
                                ? '+${((int.parse(char.stats[stat]) - 10) / 2)
                                .floor()}'
                                : ((int.parse(char.stats[stat].toString()) -
                                            10) /
                                        2)
                                    .round()
                                    .toString(),
                            style: AppTextStyles.black14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
