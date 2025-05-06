import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SavesForm extends StatelessWidget {
  const SavesForm({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        child: FormBuilderCheckboxGroup(
          initialValue: character.savingThrows,
          wrapAlignment: WrapAlignment.center,
          activeColor: AppColors.primary,
          name: 'savingThrowPicker',
          options: stats
              .map(
                (stat) => FormBuilderFieldOption(
                  value: stat,
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) =>
                        SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(stat),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
