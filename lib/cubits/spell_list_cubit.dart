import 'package:dnd_helper/api/failure.dart';
import 'package:dnd_helper/api/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';

class SpellListCubit extends Cubit<SpellListState> {
  final ApiRepository apiRepository;

  SpellListCubit({required this.apiRepository})
      : super(SpellListInitial());

  Future<void> fetchSpellListApi(String params) async {
    emit(SpellListLoading());
    try {
      final List<SpellListItem>? spells =
          await apiRepository.getSpellListItems(params);
      emit(SpellListLoaded(spells: spells ?? []));
    } catch (err) {
      emit(SpellListError(Failure(message: err.toString())));
      print('Error: $err');
    }
  }
}

abstract class SpellListState {}

class SpellListInitial extends SpellListState {}

class SpellListLoading extends SpellListState {}

class SpellListLoaded extends SpellListState {
  SpellListLoaded({required this.spells});

  final List<SpellListItem> spells;
}

class SpellListError extends SpellListState {
  SpellListError(this.failure);

  final Failure failure;
}
