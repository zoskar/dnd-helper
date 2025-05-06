import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:dnd_helper/cubits/rule_section_cubit.dart';
import 'package:dnd_helper/utils/app_colors.dart';
import 'package:dnd_helper/screens/rules/rule_view.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  static const List<String> rulesList = [
    'adventuring',
    'appendix',
    'combat',
    'equipment',
    'spellcasting',
    'using-ability-scores',
  ];

  @override
  Widget build(BuildContext context) {
    context.read<RuleSectionCubit>().fetch(rulesList);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: BlocBuilder<RuleSectionCubit, RuleSectionState>(
          builder: (context, state) {
            if (state is RulesLoading) {
              return const CircularProgressIndicator(
                color: AppColors.primary,
              );
            } else if (state is RuleSectionError) {
              return Text(state.failure.message);
            } else if (state is RuleSectionLoaded) {
              final rules = state.rules;
              return rules.where((e) => e != null).isEmpty
                  ? const Text(
                      'No rules found - check your internet connection',
                    )
                  : ListView.builder(
                      itemCount: rules.length,
                      itemBuilder: (context, index) {
                        final RuleSection rule = rules[index]!;

                        return ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          collapsedIconColor: AppColors.secondary,
                          //collapsedTextColor: Colors.amber,
                          iconColor: AppColors.primary,
                          textColor: AppColors.primary,
                          backgroundColor: Colors.grey.shade100,
                          title: Text(
                            rule.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          children: rule.subsections
                              .map(
                                (r) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleRulePage(
                                          ruleURL: r['url']!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      r['name']!,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
