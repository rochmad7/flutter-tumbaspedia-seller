part of '../cubit/product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductLoadingFailed extends ProductState {
  final String message;
  final Map<String, dynamic> error;

  ProductLoadingFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class ProductAdded extends ProductState {
  final Product product;

  ProductAdded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductAddedFailed extends ProductState {
  final String message;
  final Map<String, dynamic> error;

  ProductAddedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class ProductFetch extends ProductState {
  final Product product;

  ProductFetch(this.product);

  @override
  List<Object> get props => [product];
}

class ProductFetchFailed extends ProductState {
  final String message;
  final Map<String, dynamic> error;

  ProductFetchFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class ProductEdited extends ProductState {
  final Product product;

  ProductEdited(this.product);

  @override
  List<Object> get props => [product];
}

class ProductEditedFailed extends ProductState {
  final String message;
  final Map<String, dynamic> error;

  ProductEditedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class ProductDeleted extends ProductState {
  final String message;

  ProductDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class ProductDeletedFailed extends ProductState {
  final String message;
  final Map<String, dynamic> error;

  ProductDeletedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}
