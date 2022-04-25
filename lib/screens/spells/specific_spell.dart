import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/spellFetch_cubit.dart';

class SpellView extends StatelessWidget {
  final String spellName;

  const SpellView({
    Key? key,
    required this.spellName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SpellfetchCubit>().fetchSpellApi(spellName);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<SpellfetchCubit, SpellfetchcubitState>(
          builder: (context, state) {
            if (state is SpellfetchcubitLoading) {
              return const CircularProgressIndicator();
            } else if (state is SpellfetchcubitError) {
              return Text(state.failure.message);
            } else if (state is SpellfetchcubitLoaded) {
              final spell = state.spell;
              return Text(spell.toString());
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
