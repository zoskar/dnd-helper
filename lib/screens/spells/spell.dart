import 'package:dnd_helper/screens/spells/widgets/single_spell.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/spell_cubit.dart';

class SpellView extends StatelessWidget {
  final String spellName;

  const SpellView({
    Key? key,
    required this.spellName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SpellCubit>().fetch(spellName);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myGradient,
          ),
        ),
        title: Text(
          spellName.replaceAll('-', ' ').capitalize(),
        ),
      ),
      body: Center(
        child: BlocBuilder<SpellCubit, SpellState>(
          builder: (context, state) {
            if (state is SpellLoading) {
              return const CircularProgressIndicator(
                color: AppColors.primary,
              );
            } else if (state is SpellError) {
              return Text(state.failure.message);
            } else if (state is SpellLoaded) {
              final spell = state.spell;
              return SpellContent(spell: spell);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  static const divider_thickness = 2.0;

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.primary,
      thickness: divider_thickness,
    );
  }
}
