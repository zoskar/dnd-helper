import 'package:dnd_helper/cubits/character_cubit.dart';
import 'package:dnd_helper/data/file_handler.dart';
import 'package:dnd_helper/data/models.dart';
import 'package:dnd_helper/screens/character/picked/widgets/resource_form.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ResoureManager extends StatelessWidget {
  const ResoureManager({
    required this.fileHandler,
    Key? key,
  }) : super(key: key);

  final FileHandler fileHandler;

  @override
  Widget build(BuildContext context) {
    final Character char = context.read<CharacterCubit>().pickedChar;

    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // ignore: use_decorated_box
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myGradient,
          ),
        ),
        title: const Text(
          'Resources',
          style: AppTextStyles.appbar,
        ),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: char.resources
                .map(
                  (resource) => Column(
                    children: [
                      ListTile(
                        trailing: InkWell(
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.secondary,
                          ),
                          onTap: () async {
                            await fileHandler.deleteChar(char);

                            char.resources.remove(resource);
                            await fileHandler.writeChar(char);
                            context
                                .read<CharacterCubit>()
                                .pickCharacter(char, fileHandler);
                            Navigator.pop(context);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResoureManager(
                                  fileHandler: fileHandler,
                                ),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          resource.name,
                          style: AppTextStyles.black18,
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                )
                .toList(),
          ),
          InkWell(
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResourceForm(
                    formKey: formKey,
                    fileHandler: fileHandler,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
