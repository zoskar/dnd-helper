import 'package:flutter/material.dart';

import 'package:dnd_helper/utils/custom_icons.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/utils/fonts.dart';
import 'package:dnd_helper/widgets/divider.dart';

class SpellContent extends StatelessWidget {
  const SpellContent({
    required this.spell,
    super.key,
  });

  final Spell spell;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Casting time: ${spell.castingTime}',
                      style: AppTextStyles.black16,
                    ),
                    Text(
                      'Range: ${spell.range}',
                      style: AppTextStyles.black16,
                    ),
                    Text(
                      'Duration: ${spell.duration}',
                      style: AppTextStyles.black16,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (spell.ritual)
                        const Icon(
                          CustomIcons.registered,
                          size: 28,
                        ),
                      if (spell.concentration)
                        const Icon(
                          CustomIcons.copyright,
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const MyDivider(),
            Text(
              '${spell.school['name']} '
              '${spell.level == 0 ? 'Cantrip' : 'level ${spell.level}'}',
              style: AppTextStyles.black16,
            ),
            Text(
              'Components: ${spell.components.join(', ')}',
              style: AppTextStyles.black16,
            ),
            const MyDivider(),
            Text(
              '${spell.desc.join(", ").toString()}\n\n'
              '${spell.higherLevel.isEmpty ? '' : spell.higherLevel[0].toString()}',
              style: AppTextStyles.black16,
            ),
          ],
        ),
      );
}
