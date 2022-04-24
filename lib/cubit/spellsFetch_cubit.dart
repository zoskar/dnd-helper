import 'package:bloc/bloc.dart';
import 'package:dnd_helper/api/api_repository.dart';
import 'package:equatable/equatable.dart';

class SpellsfetchCubit extends Cubit<SpellsfetchcubitState> {
  final ApiRepository apiRepository;

  SpellsfetchCubit({required this.apiRepository})
      : super(SpellsfetchcubitInitial());

  Future<void> fetchSpellsApi(String params) async {
    emit(SpellsfetchcubitLoading());
    try {
      final List<dynamic>? spellList =
          await apiRepository.getSpellsList(params);
      emit(SpellsfetchcubitLoaded(spellsList: spellList ?? []));
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
  final List<dynamic> spellsList;

  const SpellsfetchcubitLoaded({required this.spellsList});

  @override
  List<Object> get props => [spellsList];
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
