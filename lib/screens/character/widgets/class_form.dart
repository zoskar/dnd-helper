import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ClassForm extends StatelessWidget {
  const ClassForm({
    required this.character,
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text(
            'Character class',
            style: AppTextStyles.header,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: FormBuilderDropdown(
                initialValue: character.characterClass,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                hint: const Text('Pick class'),
                isExpanded: false,
                name: 'classPicker',
                items: classes
                    .map(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      );
}
