import 'package:bloc/bloc.dart';
import 'package:dnd_helper/cubit/spells_model.dart';
import 'package:dnd_helper/repository/api_repository.dart';
import 'package:equatable/equatable.dart';

import '../models/failure_model.dart';

part 'spellsFetch_state.dart';

class PostfetchcubitCubit extends Cubit<PostfetchcubitState> {
  final ApiRepository apiRepository;

  PostfetchcubitCubit({required this.apiRepository})
      : super(PostfetchcubitInitial());

  Future<void> fetchSpellsApi() async {
    emit(PostfetchcubitLoading());
    try {
      print('aaa');
      final List<dynamic>? postList = await apiRepository.getPostList();
      print('bbb');
      emit(PostfetchcubitLoaded(postList: postList ?? []));
    } on Failure catch (e) {
      emit(PostfetchcubitError(e));
    } catch (e) {
      print('Error: $e');
    }
  }
}
