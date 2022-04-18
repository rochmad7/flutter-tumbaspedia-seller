part of '../cubit/category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryLoadingFailed extends CategoryState {
  final String message;

  CategoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
