import 'package:bloc/bloc.dart';
import 'package:dnd_helper/cubit/spells_model.dart';
import 'package:dnd_helper/repository/api_repository.dart';
import 'package:equatable/equatable.dart';

import '../models/failure_model.dart';

part 'spellsFetch_state.dart';

class SpellsfetchCubit extends Cubit<SpellsfetchcubitState> {
  final ApiRepository apiRepository;

  SpellsfetchCubit({required this.apiRepository})
      : super(SpellsfetchcubitInitial());

  Future<void> fetchSpellsApi() async {
    emit(SpellsfetchcubitLoading());
    try {
      final List<dynamic>? postList = await apiRepository.getPostList();
      emit(SpellsfetchcubitLoaded(postList: postList ?? []));
    } on Failure catch (e) {
      emit(SpellsfetchcubitError(e));
    } catch (e) {
      print('Error: $e');
    }
  }
}
