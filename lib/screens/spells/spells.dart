import 'package:dnd_helper/cubits/spells_cubit.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/screens/spells/specific_spell.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({Key? key}) : super(key: key);

  @override
  State<SpellsPage> createState() => _SpellsPageState();

  
}

class _SpellsPageState extends State<SpellsPage> {
  String _level = '';
  String _spellClass = '';
  String _school = '';
  String _params = '';



  @override
  Widget build(BuildContext context) {
    context.read<SpellsCubit>().fetchSpellsApi(_params);
    return Scaffold(
      body: Column(children: [
        const FilterButtons(),
        BlocBuilder<SpellsCubit, SpellsState>(
          builder: (context, state) {
            if (state is SpellsLoading) {
              return const CircularProgressIndicator();
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

class SpellItem extends StatelessWidget {
  const SpellItem({
    Key? key,
    required this.singleSpell,
  }) : super(key: key);

  final Spells singleSpell;

  @override
  Widget build(BuildContext context) {
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
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondary,
            ),
            title: Text(
              singleSpell.name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Divider(),
        ],
      ),
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
                  return Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('Pick spell level'),
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text(
              'Level',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.secondary,
              fixedSize: const Size(100, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Class',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.secondary,
              fixedSize: const Size(100, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'School',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void showDialog(BuildContext context) => showDialog(
        context,
      );
}
