import 'dart:math';

import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CurrentHpButtons extends StatelessWidget {
  const CurrentHpButtons({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
    required this.fileHandler,
    required this.char,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final FileHandler fileHandler;
  final Character char;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () async {
            if (_formKey.currentState!.saveAndValidate()) {
              await fileHandler.deleteChar(char);
              var value = _formKey.currentState?.value['currentHpPicker'];
              if (value == null) {
                value = 1;
              } else {
                value = int.parse(
                  _formKey.currentState?.value['currentHpPicker'],
                );
              }
              value = max(0, char.currentHp - value);
              char.currentHp = value;
              await fileHandler.writeChar(char);
              context.read<CharacterCubit>().pickCharacter(char, fileHandler);
            }
          },
          child: const Text(
            '-',
            style: AppTextStyles.black40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
            child: SizedBox(
              height: 50,
              width: 68,
              child: FormBuilderTextField(
                name: 'currentHpPicker',
                keyboardType: TextInputType.number,
                maxLength: 3,
                validator: FormBuilderValidators.integer(
                  errorText: 'number!',
                ),
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Hp',
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green.shade400),
          onPressed: () async {
            if (_formKey.currentState!.saveAndValidate()) {
              await fileHandler.deleteChar(char);
              var value = _formKey.currentState?.value['currentHpPicker'];
              if (value == null) {
                value = 1;
              } else {
                value = int.parse(
                  _formKey.currentState?.value['currentHpPicker'],
                );
              }
              value = min(char.hp, char.currentHp + value);
              char.currentHp = value;
              await fileHandler.writeChar(char);
              context.read<CharacterCubit>().pickCharacter(char, fileHandler);
            }
          },
          child: const Text(
            '+',
            style: AppTextStyles.black40,
          ),
        ),
      ],
    );
  }
}
