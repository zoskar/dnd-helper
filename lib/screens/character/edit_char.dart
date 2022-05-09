import 'package:dnd_helper/data/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../data/models.dart';
import '../../utils/app_colors.dart';
import '../../utils/fonts.dart';
import '../../utils/listings.dart';
import '../../widgets/divider.dart';

class EditChar extends StatelessWidget {
  EditChar({Key? key, required this.character, required this.fileHandler})
      : super(key: key);

  final FileHandler fileHandler;
  final Character character;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myGradient,
          ),
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          character.name,
          style: AppTextStyles.title,
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        child: ListView(
          addAutomaticKeepAlives: true,
          padding: const EdgeInsets.all(8.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
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
                          items: classes.map(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Level',
                      style: AppTextStyles.header,
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
                          items: levels.map(
                            (int value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const MyDivider(),
            const Text(
              'Character Name',
              style: AppTextStyles.header,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                maxLength: 30,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Enter name'),
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
              style: AppTextStyles.header,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                initialValue: character.subclass,
                name: 'subclassPicker',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'Subclass',
                ),
              ),
            ),
            const MyDivider(),
            const Text(
              'Character Race',
              style: AppTextStyles.header,
            ),
            Padding(
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
            ),
            const MyDivider(),
            const Text(
              'Character Stats',
              style: AppTextStyles.header,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: stats
                  .map((stat) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          maxLength: 2,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Enter value'),
                            FormBuilderValidators.integer(
                                errorText: 'Enter a number'),
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
                      ))
                  .toList(),
            ),
            const MyDivider(),
            const Text(
              'Saving throw proficiency',
              style: AppTextStyles.header,
            ),
            Container(
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
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Text(stat),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Skills',
                style: AppTextStyles.header,
              ),
            ),
            Container(
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
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(skill),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Max HP', style: AppTextStyles.p),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderTextField(
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.integer(
                                  errorText: 'Must be a number'),
                              FormBuilderValidators.min(1,
                                  errorText: 'Must be positive'),
                              FormBuilderValidators.required(
                                  errorText: 'Enter HP'),
                            ]),
                            initialValue: character.hp.toString(),
                            name: 'hpPicker',
                            decoration: const InputDecoration(
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
                  ),
                  Column(
                    children: [
                      const Text('AC', style: AppTextStyles.p),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FormBuilderTextField(
                            maxLength: 2,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.integer(
                                  errorText: 'Must be a number'),
                              FormBuilderValidators.min(1,
                                  errorText: 'Must be positive'),
                              FormBuilderValidators.required(
                                  errorText: 'Enter HP')
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
                  ),
                ],
              ),
            ),
            const MyDivider(),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Hold to delete character"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              onLongPress: () {
                fileHandler.deleteChar(character);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.pop(context);
              },
              child: const Text('Delete character'),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              Map<String, dynamic>? data = _formKey.currentState?.value;

              fileHandler.deleteChar(character);
              fileHandler.writeChar(
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
            style: AppTextStyles.headerW,
          ),
        ),
      ),
    );
  }
}
