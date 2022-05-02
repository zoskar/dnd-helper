import 'package:flutter/material.dart';
import '../../../api/models.dart';
import '../../../utils/app_colors.dart';
import '../spell.dart';

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
