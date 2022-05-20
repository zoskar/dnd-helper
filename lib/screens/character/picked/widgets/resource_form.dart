import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/utils/listings.dart';
import 'package:dnd_helper/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ResourceForm extends StatelessWidget {
  const ResourceForm({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

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
          title: const Text(
            'Add resource',
            style: AppTextStyles.appbar,
          ),
        ),
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Resource name',
                    style: AppTextStyles.black24,
                  ),
                ),
                FormBuilderTextField(
                  name: 'resNamePicker',
                  maxLength: 20,
                  validator: FormBuilderValidators.required(
                    errorText: 'Cannot be empty',
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    label: Text('Resource name'),
                  ),
                ),
                const MyDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Uses before rest',
                      style: AppTextStyles.black24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: FormBuilderDropdown(
                        initialValue: uses[0],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        hint: const Text('Uses'),
                        isExpanded: false,
                        name: 'resUsesPicker',
                        items: uses
                            .map(
                              (int value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const MyDivider(),
                const Text(
                  'Resets on: ',
                  style: AppTextStyles.black24,
                ),
                FormBuilderRadioGroup(
                  validator: FormBuilderValidators.required(
                    errorText: 'Enter value!',
                  ),
                  wrapAlignment: WrapAlignment.center,
                  wrapSpacing: 32,
                  name: 'resCooldownPicker',
                  options: const [
                    FormBuilderFieldOption(
                      value: true,
                      child: Text('Short rest'),
                    ),
                    FormBuilderFieldOption(
                      value: false,
                      child: Text('Long rest'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      primary: AppColors.secondary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                    child: const Text(
                      'Create',
                      style: AppTextStyles.white18,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
