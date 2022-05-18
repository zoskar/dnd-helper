import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/screens/character/widgets/form/ac_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/class_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/delete_button.dart';
import 'package:dnd_helper/screens/character/widgets/form/hp_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/level_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/race_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/saves_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/skills_form.dart';
import 'package:dnd_helper/screens/character/widgets/form/subclass_form.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:dnd_helper/widgets/divider.dart';
import 'package:dnd_helper/data/file_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditChar extends StatelessWidget {
  EditChar({
    required this.names,
    required this.character,
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;
  final Character character;
  final List<String> names;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // ignore: use_decorated_box
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.myGradient,
            ),
          ),
          backgroundColor: AppColors.primary,
          title: Text(
            character.name,
            style: AppTextStyles.appbar,
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          child: ListView(
            //addAutomaticKeepAlives: true,
            padding: const EdgeInsets.all(8.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClassForm(character: character),
                  LevelForm(character: character),
                ],
              ),
              const MyDivider(),
              const Text(
                'Character Name',
                style: AppTextStyles.black18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  maxLength: 30,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Enter name'),
                    (newName) {
                      if (names.contains(newName) &&
                          newName != character.name) {
                        return 'Name taken';
                      }
                      return null;
                    }
                  ]),
                  initialValue: character.name,
                  name: 'namePicker',
                  decoration: const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: 'Name',
                  ),
                ),
              ),
              const MyDivider(),
              const Text(
                'Character Subclass',
                style: AppTextStyles.black18,
              ),
              SubclassForm(character: character),
              const MyDivider(),
              const Text(
                'Character Race',
                style: AppTextStyles.black18,
              ),
              RaceForm(character: character),
              const MyDivider(),
              const Text(
                'Character Stats',
                style: AppTextStyles.black18,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: stats
                    .map(
                      (stat) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          maxLength: 2,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Enter value',
                            ),
                            FormBuilderValidators.integer(
                              errorText: 'Enter a number',
                            ),
                          ]),
                          initialValue: character.stats[stat].toString(),
                          name: '${stat.toLowerCase()}Picker',
                          decoration: InputDecoration(
                            counterText: '',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            labelText: stat,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const MyDivider(),
              const Text(
                'Saving throw proficiency',
                style: AppTextStyles.black18,
              ),
              SavesForm(character: character),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Skills',
                  style: AppTextStyles.black18,
                ),
              ),
              SkillsForm(character: character),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HpForm(character: character),
                    AcForm(character: character),
                  ],
                ),
              ),
              const MyDivider(),
              DeleteButton(fileHandler: fileHandler, character: character),
              const Padding(
                padding: EdgeInsets.only(bottom: 100),
              ),
            ],
          ),
        ),
        floatingActionButton: ConfirmButton(
          formKey: _formKey,
          fileHandler: fileHandler,
          character: character,
        ),
      );
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    required GlobalKey<FormBuilderState> formKey,
    required this.fileHandler,
    required this.character,
    Key? key,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final FileHandler fileHandler;
  final Character character;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 120.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          onPressed: () async {
            await fileHandler.deleteChar(character);

            if (_formKey.currentState!.saveAndValidate()) {
              Map<String, dynamic>? data = _formKey.currentState?.value;
              await fileHandler.writeChar(
                Character(
                  name: data?['namePicker'] ?? character.name,
                  characterClass:
                      data?['classPicker'] ?? character.characterClass,
                  race: data?['racePicker'] ?? character.race,
                  level: int.parse(data?['levelPicker']),
                  subclass: data?['subclassPicker'] ?? character.subclass,
                  stats: {
                    'STR': data?['strPicker'],
                    'DEX': data?['dexPicker'],
                    'CON': data?['conPicker'],
                    'WIS': data?['wisPicker'],
                    'INT': data?['intPicker'],
                    'CHA': data?['chaPicker']
                  },
                  savingThrows:
                      data?['savingThrowPicker'] ?? character.savingThrows,
                  skills: data?['skillPicker'] ?? character.skills,
                  resources: character.resources,
                  hp: int.parse(data?['hpPicker'] ?? character.hp.toString()),
                  ac: int.parse(data?['acPicker'] ?? character.ac.toString()),
                ),
              );
              Navigator.pop(context);
              //_formKey.currentState!.reset();
            }
            _formKey.currentState!.validate();
          },
          child: const Text(
            'Confirm',
            style: AppTextStyles.white18,
          ),
        ),
      );
}
