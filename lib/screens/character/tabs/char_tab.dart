import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';

class CharTab extends StatelessWidget {
  const CharTab({
    required this.char,
    Key? key,
  }) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              char.name,
              style: AppTextStyles.black40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      child: Text(char.race, style: AppTextStyles.black18)),
                  SizedBox(
                      child: Text(char.characterClass,
                          style: AppTextStyles.black18)),
                  SizedBox(
                      child: Text('Level ${char.level}',
                          style: AppTextStyles.black18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                char.subclass,
                style: AppTextStyles.black18,
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: stats
                  .map(
                    (stat) => Card(
                      shadowColor: AppColors.secondary,
                      elevation: 10,
                      //surfaceTintColor: AppColors.primary,
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
                            char.stats[stat],
                            style: AppTextStyles.black40,
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            height: 16,
                            width: 40,
                            color: AppColors.background,
                            child: Text(
                              int.parse(char.stats[stat]) - 10 > 0
                                  ? '+${((int.parse(char.stats[stat]) - 10) / 2).floor()}'
                                  : ((int.parse(char.stats[stat]) - 10) / 2)
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
