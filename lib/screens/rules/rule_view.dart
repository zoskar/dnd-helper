import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/fonts.dart';

class SingleRulePage extends StatelessWidget {
  const SingleRulePage({Key? key, required this.ruleURL}) : super(key: key);

  final String ruleURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'Dnd Helper',
            style: AppTextStyles.h,
          ),
        ),
      body: Column(
        children: [
          Text(ruleURL)
        ],
      ),
    );
  }
}
