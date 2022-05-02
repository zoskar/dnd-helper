import 'package:dnd_helper/screens/rules/rule_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/models.dart';
import '../../cubits/rules_cubit.dart';
import '../../utils/app_colors.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  static const List<String> rulesList = [
    'adventuring',
    'appendix',
    'combat',
    'equipment',
    'spellcasting',
    'using-ability-scores'
  ];

  @override
  Widget build(BuildContext context) {
    context.read<RulesCubit>().fetch(rulesList);
    return Scaffold(
      body: Center(
        child: BlocBuilder<RulesCubit, RulesState>(
          builder: (context, state) {
            if (state is RulesLoading) {
              return const CircularProgressIndicator(
                color: AppColors.primary,
              );
            } else if (state is RulesError) {
              return Text(state.failure.message);
            } else if (state is RulesLoaded) {
              final rules = state.rules;
              return ListView.builder(
                  itemCount: rules.length,
                  itemBuilder: ((context, index) {
                    final Rules rule = rules[index];

                    return ExpansionTile(
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
                                        builder: (context) =>
                                            SingleRulePage(ruleURL: r['url']!)));
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
                  }));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
