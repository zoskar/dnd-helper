import 'package:dnd_helper/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/screens/spells/spell.dart';

class SpellItem extends StatelessWidget {
  const SpellItem({
    required this.singleSpell,
    super.key,
  });

  final SpellListItem singleSpell;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpellView(
                spellName: singleSpell.index,
              ),
            ),
          );
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
                style: AppTextStyles.black18,
              ),
            ),
            const Divider(),
          ],
        ),
      );
}
