import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class RulesCubit extends Cubit<RulesState> {
  RulesCubit({required this.apiRepository}) : super(RulesInitial());

  final ApiRepository apiRepository;

  Future<void> fetch(List<String> rulesList) async {
    emit(RulesLoading());
    try {
      final rules = await apiRepository.getRules(rulesList);
      //print('fetch:$rules');
      if (rules != null) {
        emit(RulesLoaded(rules: rules));
      } else {
        emit(RulesError(const Failure(message: 'Rule not found!')));
      }
    } catch (err) {
      emit(RulesError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class RulesState {}

class RulesInitial extends RulesState {}

class RulesLoading extends RulesState {}

class RulesLoaded extends RulesState {
  RulesLoaded({required this.rules});

  final List<Rules> rules;
}

class RulesError extends RulesState {
  RulesError(this.failure);

  final Failure failure;
}
