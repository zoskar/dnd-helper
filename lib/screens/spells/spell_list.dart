import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/cubits/spell_list_cubit.dart';
import 'package:dnd_helper/screens/spells/widgets/list_item.dart';
import 'package:dnd_helper/screens/spells/widgets/search_field.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dnd_helper/utils/fonts.dart';

String searchParams = '?';
int currentLevel = -1;
List<int> levels = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

class SpellsPage extends StatefulWidget {
  const SpellsPage({
    required this.params,
    Key? key,
  }) : super(key: key);
  final String params;

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  @override
  Widget build(BuildContext context) {
    context.read<SpellListCubit>().fetchSpellListApi(searchParams);
    return Scaffold(
      body: Column(
        children: [
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
                    showBottomSheet(context);
                  },
                  child: const Text(
                    'Filters',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<SpellListCubit, SpellListState>(
            builder: (context, state) {
              if (state is SpellListLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else if (state is SpellListError) {
                return Text(state.failure.message);
              } else if (state is SpellListLoaded) {
                final spellList = state.spells;
                return spellList.isEmpty
                    ? const Text('No spells found')
                    : Flexible(
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: spellList.length,
                            itemBuilder: (context, index) {
                              final SpellListItem singleSpell =
                                  spellList[index];

                              return SpellItem(singleSpell: singleSpell);
                            },
                          ),
                        ),
                      );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context) =>
      showModalBottomSheet<void>(
        backgroundColor: Colors.grey.shade200,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (
            BuildContext context,
            StateSetter setModalState,
          ) =>
              SizedBox(
            height: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: levels
                      .map(
                        (level) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: GridTile(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  style: AppTextStyles.black16,
                                  level == -1 ? 'Any ' : 'Level $level',
                                ),
                                Radio<int>(
                                  activeColor: AppColors.primary,
                                  value: level,
                                  groupValue: currentLevel,
                                  onChanged: (int? value) {
                                    setModalState(
                                      () {
                                        currentLevel = value!;
                                        if (currentLevel == -1) {
                                          searchParams = '';
                                        } else {
                                          searchParams = '?level=$currentLevel';
                                        }
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
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
          ),
        ),
      );
}
