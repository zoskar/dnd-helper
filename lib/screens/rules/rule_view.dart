import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dnd_helper/cubits/rule_cubit.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/utils/fonts.dart';

class SingleRulePage extends StatelessWidget {
  const SingleRulePage({
    required this.ruleURL,
    Key? key,
  }) : super(key: key);

  final String ruleURL;

  @override
  Widget build(BuildContext context) {
    context.read<RuleCubit>().fetch(ruleURL);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // ignore: use_decorated_box
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myGradient,
          ),
        ),
        backgroundColor: AppColors.primary,
        title: const Text(
          'Dnd Helper',
          style: AppTextStyles.appbar,
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
                  style: AppTextStyles.black16,
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
