part of 'spellsFetch_cubit.dart';

abstract class PostfetchcubitState extends Equatable {
  const PostfetchcubitState();

  @override
  List<Object> get props => [];
}

class PostfetchcubitInitial extends PostfetchcubitState {}

class PostfetchcubitLoading extends PostfetchcubitState {}

class PostfetchcubitLoaded extends PostfetchcubitState {
  final List<dynamic> postList;

  PostfetchcubitLoaded({required this.postList});

  @override
  List<Object> get props => [postList];
}

class PostfetchcubitError extends PostfetchcubitState {
  final Failure failure;

  PostfetchcubitError(this.failure);

  @override
  // TODO: implement props
  List<Object> get props => [failure];
}
