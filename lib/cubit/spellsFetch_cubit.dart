import 'package:bloc/bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';
import 'package:equatable/equatable.dart';

class SpellsfetchCubit extends Cubit<SpellsfetchcubitState> {
  final ApiRepository apiRepository;

  SpellsfetchCubit({required this.apiRepository})
      : super(SpellsfetchcubitInitial());

  Future<void> fetchSpellsApi() async {
    emit(SpellsfetchcubitLoading());
    try {
      final List<dynamic>? postList = await apiRepository.getSpellsList();
      emit(SpellsfetchcubitLoaded(postList: postList ?? []));
    } on Failure catch (e) {
      emit(SpellsfetchcubitError(e));
    } catch (e) {
      print('Error: $e');
    }
  }
}

abstract class SpellsfetchcubitState extends Equatable {
  const SpellsfetchcubitState();

  @override
  List<Object> get props => [];
}

class SpellsfetchcubitInitial extends SpellsfetchcubitState {}

class SpellsfetchcubitLoading extends SpellsfetchcubitState {}

class SpellsfetchcubitLoaded extends SpellsfetchcubitState {
  final List<dynamic> postList;

  const SpellsfetchcubitLoaded({required this.postList});

  @override
  List<Object> get props => [postList];
}

class SpellsfetchcubitError extends SpellsfetchcubitState {
  final Failure failure;

  SpellsfetchcubitError(this.failure);

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
