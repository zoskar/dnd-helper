import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class RuleCubit extends Cubit<RuleState> {
  RuleCubit({required this.apiRepository}) : super(RuleInitial());

  final ApiRepository apiRepository;


  Future<void> fetch(String ruleURL) async {
    emit(RuleLoading());
    try {
      final rule = await apiRepository.getRule(ruleURL);
      if (rule != null) {
        emit(RuleLoaded(rule: rule));
      } else {
        emit(RuleError(const Failure(message: 'Rule not found!')));
      }
    } catch (err) {
      emit(RuleError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class RuleState {}

class RuleInitial extends RuleState {}

class RuleLoading extends RuleState {}

class RuleLoaded extends RuleState {
  RuleLoaded({required this.rule});

  final Rule rule;
}

class RuleError extends RuleState {
  RuleError(this.failure);

  final Failure failure;
}
