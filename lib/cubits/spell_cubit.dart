import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class SpellCubit extends Cubit<SpellState> {
  SpellCubit({required this.apiRepository}) : super(SpellInitial());

  final ApiRepository apiRepository;

  Future<void> fetch(String spellName) async {
    emit(SpellLoading());
    try {
      final spell = await apiRepository.getSpell(spellName);
      if (spell != null) {
        emit(SpellLoaded(spell: spell));
      } else {
        emit(SpellError(const Failure(message: 'Spell not found!')));
      }
    } catch (err) {
      emit(SpellError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class SpellState {}

class SpellInitial extends SpellState {}

class SpellLoading extends SpellState {}

class SpellLoaded extends SpellState {
  SpellLoaded({required this.spell});

  final Spell spell;
}

class SpellError extends SpellState {
  SpellError(this.failure);

  final Failure failure;
}
