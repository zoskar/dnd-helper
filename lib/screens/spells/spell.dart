import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/extensions.dart';
import 'package:dnd_helper/utils/fonts.dart';
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
        backgroundColor: AppColors.primary,
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

class SpellContent extends StatelessWidget {
  const SpellContent({
    Key? key,
    required this.spell,
  }) : super(key: key);

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Casting time: ${spell.casting_time}',
                    style: AppTextStyles.p,
                  ),
                  Text(
                    'Range: ${spell.range}',
                    style: AppTextStyles.p,
                  ),
                  Text(
                    'Duration: ${spell.duration}',
                    style: AppTextStyles.p,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (spell.ritual)
                      const Icon(
                        Icons.r_mobiledata_sharp,
                        size: 50,
                      ),
                    if (spell.concentration)
                      const Icon(
                        Icons.garage,
                        size: 50,
                      )
                  ],
                ),
              )
            ],
          ),
          const MyDivider(),
          Text(
            '${spell.school['name']} ${spell.level == 0 ? 'Cantrip' : 'level ${spell.level}'}',
            style: AppTextStyles.p,
          ),
          Text(
            'Components: ${spell.components.join(', ')}',
            style: AppTextStyles.p,
          ),
          const MyDivider(),
          Text(
            '${spell.desc.join(", ").toString()}\n\n${spell.higher_level.isEmpty ? '' : spell.higher_level[0].toString()}',
            style: AppTextStyles.p,
          ),
        ],
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
