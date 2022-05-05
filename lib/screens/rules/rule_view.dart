import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/rule_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/fonts.dart';

class SingleRulePage extends StatelessWidget {
  const SingleRulePage({Key? key, required this.ruleURL}) : super(key: key);

  final String ruleURL;

  @override
  Widget build(BuildContext context) {
    context.read<RuleCubit>().fetch(ruleURL);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myGradient,
          ),
        ),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Dnd Helper',
          style: AppTextStyles.h,
        ),
      ),
      body: BlocBuilder<RuleCubit, RuleState>(
        builder: (context, state) {
          if (state is RuleLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is RuleError) {
            return Text(state.failure.message);
          } else if (state is RuleLoaded) {
            final rule = state.rule;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  rule.desc,
                  style: AppTextStyles.p,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
