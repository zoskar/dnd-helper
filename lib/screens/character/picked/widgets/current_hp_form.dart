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
    required this.fileHandler,
    required this.char,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final Character char;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red.shade700,
            ),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (formKey.currentState!.saveAndValidate()) {
                var value = formKey.currentState?.value['currentHpPicker'];
                if (value == null || value == '') {
                  value = 1;
                } else {
                  value = int.parse(
                    formKey.currentState?.value['currentHpPicker'],
                  );
                }
                value = max(0, char.currentHp - value);
                char.currentHp = value;
                await fileHandler.deleteChar(char);
                await fileHandler.writeChar(char);
                context.read<CharacterCubit>().pickCharacter(char, fileHandler);
              }
            },
            child: const Text(
              '-',
              style: AppTextStyles.black40,
            ),
          ),
          FormBuilder(
            key: formKey,
            child: SizedBox(
              height: 50,
              width: 68,
              child: FormBuilderTextField(
                textAlign: TextAlign.center,
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
                  label: Center(
                    child: Text('Hp'),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent.shade400,
            ),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              if (formKey.currentState!.saveAndValidate()) {
                await fileHandler.deleteChar(char);
                var value = formKey.currentState?.value['currentHpPicker'];
                if (value == null || value == '') {
                  value = 1;
                } else {
                  value = int.parse(
                    formKey.currentState?.value['currentHpPicker'],
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
      ),
    );
  }
}
