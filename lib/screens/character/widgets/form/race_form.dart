import 'package:dnd_helper/data/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RaceForm extends StatelessWidget {
  const RaceForm({
    required this.character,
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          maxLength: 30,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Enter race'),
          ]),
          initialValue: character.race,
          name: 'racePicker',
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelText: 'Race',
          ),
        ),
      );
}
