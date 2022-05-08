import 'package:dnd_helper/utils/custom_icons_icons.dart';
import 'package:flutter/material.dart';

import '../../../api/models.dart';
import '../../../utils/fonts.dart';
import '../../../widgets/divider.dart';

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
                        CustomIcons.registered,
                        size: 28,
                      ),
                    if (spell.concentration)
                      const Icon(
                        CustomIcons.copyright,
                        size: 28,
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