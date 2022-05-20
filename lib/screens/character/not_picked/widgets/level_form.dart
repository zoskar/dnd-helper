import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LevelForm extends StatelessWidget {
  const LevelForm({
    required this.character,
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text(
            'Level',
            style: AppTextStyles.black18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: FormBuilderDropdown(
                initialValue: character.level.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                hint: const Text('Level'),
                isExpanded: false,
                name: 'levelPicker',
                items: levels
                    .map(
                      (int value) => DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      );
}
