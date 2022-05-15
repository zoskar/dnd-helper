import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SkillsForm extends StatelessWidget {
  const SkillsForm({
    required this.character,
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        child: FormBuilderCheckboxGroup(
          initialValue: character.skills,
          wrapAlignment: WrapAlignment.center,
          activeColor: AppColors.primary,
          name: 'skillPicker',
          options: skills
              .map(
                (skill) => FormBuilderFieldOption(
                  value: skill,
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) =>
                        SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(skill),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
