import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class SpellsCubit extends Cubit<SpellsState> {
  final ApiRepository apiRepository;

  SpellsCubit({required this.apiRepository})
      : super(SpellsInitial());

  Future<void> fetchSpellsApi(String params) async {
    emit(SpellsLoading());
    try {
      final List<Spells>? spells =
          await apiRepository.getSpellsList(params);
      emit(SpellsLoaded(spells: spells ?? []));
    } catch (err) {
      emit(SpellsError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class SpellsState {}

class SpellsInitial extends SpellsState {}

class SpellsLoading extends SpellsState {}

class SpellsLoaded extends SpellsState {
  SpellsLoaded({required this.spells});

  final List<Spells> spells;
}

class SpellsError extends SpellsState {
  SpellsError(this.failure);

  final Failure failure;
}
