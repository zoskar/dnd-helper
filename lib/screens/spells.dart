import 'package:dnd_helper/cubit/spellsFetch_cubit.dart';
import 'package:dnd_helper/api/spells_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsPage extends StatelessWidget {
  SpellsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<SpellsfetchCubit>().fetchSpellsApi();
    return Scaffold(
      body: Center(
        child: BlocBuilder<SpellsfetchCubit, SpellsfetchcubitState>(
          builder: (context, state) {
            if (state is SpellsfetchcubitLoading) {
              return const CircularProgressIndicator();
            } else if (state is SpellsfetchcubitError) {
              return Text(state.failure.message);
            } else if (state is SpellsfetchcubitLoaded) {
              final spellList = state.postList;
              return spellList.isEmpty
                  ? const Text('')
                  : ListView.builder(
                      itemCount: spellList.length,
                      itemBuilder: ((context, index) {
                        final Spells singleSpell = spellList[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios),
                              title: Text(
                                singleSpell.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      }));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
