import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class RuleSectionCubit extends Cubit<RuleSectionState> {
  RuleSectionCubit({required this.apiRepository}) : super(RuleSectionInitial());

  final ApiRepository apiRepository;

  Future<void> fetch(List<String> rulesList) async {
    emit(RulesLoading());
    try {
      final rules = await Future.wait(
          rulesList.map((rule) => apiRepository.getRuleSection(rule)));

      emit(RuleSectionLoaded(rules: rules));
    } catch (err) {
      emit(RuleSectionError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class RuleSectionState {}

class RuleSectionInitial extends RuleSectionState {}

class RulesLoading extends RuleSectionState {}

class RuleSectionLoaded extends RuleSectionState {
  RuleSectionLoaded({required this.rules});

  final List<RuleSection?> rules;
}

class RuleSectionError extends RuleSectionState {
  RuleSectionError(this.failure);

  final Failure failure;
}
