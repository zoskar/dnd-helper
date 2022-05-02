import 'package:dnd_helper/cubits/spells_cubit.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/screens/spells/widgets/list_item.dart';
import 'package:dnd_helper/screens/spells/widgets/search_field.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String params = '?';
int currentLevel = -1;
List<int> levels = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

class SpellsPage extends StatefulWidget {
  final String params;
  const SpellsPage({Key? key, required this.params}) : super(key: key);

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  @override
  Widget build(BuildContext context) {
    context.read<SpellsCubit>().fetchSpellsApi(params);
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchField(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondary,
                  fixedSize: const Size(100, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SizedBox(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GridView.count(
                                  childAspectRatio: (2), crossAxisCount: 3,
                                  //scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: levels
                                      .map(
                                        (level) => ListTile(
                                          title: Text(level == -1
                                              ? 'Any '
                                              : 'Lvl $level'),
                                          trailing: Radio<int>(
                                            activeColor: AppColors.primary,
                                            value: level,
                                            groupValue: currentLevel,
                                            onChanged: (int? value) {
                                              setModalState(() {
                                                currentLevel = value!;
                                                if (currentLevel == -1) {
                                                  params = '';
                                                } else {
                                                  params =
                                                      '?level=$currentLevel';
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.secondary,
                                      fixedSize: const Size(100, 52),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      'Filter',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  'Filters',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<SpellsCubit, SpellsState>(
          builder: (context, state) {
            if (state is SpellsLoading) {
              return const CircularProgressIndicator(
                color: AppColors.primary,
              );
            } else if (state is SpellsError) {
              return Text(state.failure.message);
            } else if (state is SpellsLoaded) {
              final spellList = state.spells;
              return spellList.isEmpty
                  ? const Text('No spells found')
                  : Flexible(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: spellList.length,
                            itemBuilder: ((context, index) {
                              final Spells singleSpell = spellList[index];

                              return SpellItem(singleSpell: singleSpell);
                            })),
                      ),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ]),
    );
  }
}
