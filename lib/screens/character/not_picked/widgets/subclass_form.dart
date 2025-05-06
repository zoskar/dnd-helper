import 'package:dnd_helper/data/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SubclassForm extends StatelessWidget {
  const SubclassForm({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          maxLength: 48,
          initialValue: character.subclass,
          name: 'subclassPicker',
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelText: 'Subclass',
          ),
        ),
      );
}
