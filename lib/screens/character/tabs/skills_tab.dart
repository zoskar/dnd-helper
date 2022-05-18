import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';

class SkillsTab extends StatelessWidget {
  const SkillsTab({
    required this.char,
    Key? key,
  }) : super(key: key);

  final Character char;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shadowColor: AppColors.secondary,
                elevation: 10,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Saving Throws',
                        style: AppTextStyles.black18,
                      ),
                    ),
                    SizedBox(
                      //width: 200,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: stats.map((s) {
                          final bool prof = char.savingThrows.contains(s);
                          int value =
                              ((int.parse(char.stats[s].toString()) - 10) / 2)
                                  .floor();
                          if (prof) {
                            value += proficiency[char.level] as int;
                          }
                          return Row(
                            children: [
                              if (prof)
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.circle),
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.circle_outlined),
                                ),
                              SizedBox(
                                width: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (value > 0)
                                      const Text(
                                        '+',
                                        style: AppTextStyles.black16,
                                      ),
                                    Text(
                                      value.toString(),
                                      style: AppTextStyles.black16,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  statistics[s].toString(),
                                  style: AppTextStyles.black16,
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shadowColor: AppColors.secondary,
                elevation: 15,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Skills',
                        style: AppTextStyles.black18,
                      ),
                    ),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: skills.map((s) {
                        final bool prof = char.skills.contains(s);
                        String? stat = bonuses[s];
                        int value =
                            ((int.parse(char.stats[stat].toString()) - 10) / 2)
                                .floor();

                        if (prof) value += proficiency[char.level] as int;

                        return Row(
                          children: [
                            if (prof)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.circle),
                              )
                            else
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.circle_outlined),
                              ),
                            Row(
                              children: [
                                if (value > 0)
                                  const Text(
                                    '+',
                                    style: AppTextStyles.black14,
                                  ),
                                Text(
                                  value.toString(),
                                  style: AppTextStyles.black14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    s,
                                    style: AppTextStyles.black14,
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
