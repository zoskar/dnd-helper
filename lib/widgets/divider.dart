import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  static const _dividerThickness = 2.0;
  static const _paddingTB = 8.0;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: _paddingTB, top: _paddingTB),
      child: Divider(
        color: AppColors.primary,
        thickness: _dividerThickness,
      ),
    );
  }
}
