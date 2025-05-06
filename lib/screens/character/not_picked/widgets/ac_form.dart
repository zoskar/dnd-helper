import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AcForm extends StatelessWidget {
  const AcForm({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text('AC', style: AppTextStyles.black16),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                maxLength: 2,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.integer(
                    errorText: 'Must be a number',
                  ),
                  FormBuilderValidators.min(
                    1,
                    errorText: 'Must be positive',
                  ),
                  FormBuilderValidators.required(
                    errorText: 'Enter HP',
                  ),
                ]),
                initialValue: character.ac.toString(),
                name: 'acPicker',
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
