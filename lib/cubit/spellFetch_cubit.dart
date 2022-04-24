import 'package:bloc/bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';
import 'package:equatable/equatable.dart';

import '../api/models.dart';

class SpellfetchCubit extends Cubit<SpellfetchcubitState> {
  final ApiRepository apiRepository;

  SpellfetchCubit({required this.apiRepository})
      : super(SpellfetchcubitInitial());

  Future<void> fetchSpellApi(String spellName) async {
    emit(SpellfetchcubitLoading());
    try {
      final Spell spell = await apiRepository.getSpellList(spellName);
      emit(SpellfetchcubitLoaded(spell: spell));
    } on Failure catch (e) {
      emit(SpellfetchcubitError(e));
    } catch (e) {
      print('Error: $e');
    }
  }
}

abstract class SpellfetchcubitState extends Equatable {
  const SpellfetchcubitState();

  @override
  List<Object> get props => [];
}

class SpellfetchcubitInitial extends SpellfetchcubitState {}

class SpellfetchcubitLoading extends SpellfetchcubitState {}

class SpellfetchcubitLoaded extends SpellfetchcubitState {
  final Spell spell;

  const SpellfetchcubitLoaded({required this.spell});

  @override
  List<Object> get props => [spell];
}

class SpellfetchcubitError extends SpellfetchcubitState {
  final Failure failure;

  SpellfetchcubitError(this.failure);

  @override
  // TODO: implement props
  List<Object> get props => [failure];
}

class Failure {
  final String message;
  final String code;

  const Failure({
    this.message = '',
    this.code = '',
  });
}
