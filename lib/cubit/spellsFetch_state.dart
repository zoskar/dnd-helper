part of 'spellsFetch_cubit.dart';

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
