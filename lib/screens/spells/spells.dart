import 'package:dnd_helper/cubit/spellsFetch_cubit.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/screens/spells/specific_spell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({Key? key}) : super(key: key);

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  String _params = '';

  @override
  Widget build(BuildContext context) {
    context.read<SpellsfetchCubit>().fetchSpellsApi(_params);
    return Scaffold(
      body: Column(children: [
        const FilterButtons(),
        BlocBuilder<SpellsfetchCubit, SpellsfetchcubitState>(
          builder: (context, state) {
            if (state is SpellsfetchcubitLoading) {
              return const CircularProgressIndicator();
            } else if (state is SpellsfetchcubitError) {
              return Text(state.failure.message);
            } else if (state is SpellsfetchcubitLoaded) {
              final spellList = state.spellsList;
              return spellList.isEmpty
                  ? const Text('')
                  : Expanded(
                      child: ListView.builder(
                          itemCount: spellList.length,
                          itemBuilder: ((context, index) {
                            final Spells singleSpell = spellList[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SpellView(
                                              spellName: singleSpell.index,
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    title: Text(
                                      singleSpell.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          })),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ]),
    );
  }
}

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: null,
            child: const Text(
              'Level',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: null,
            child: const Text(
              'Class',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: null,
            child: const Text(
              'School',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
