part of '../cubit/shop_cubit.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoaded extends ShopState {
  final Shop shop;

  ShopLoaded(this.shop);

  @override
  List<Object> get props => [shop];
}

class ShopLoadingFailed extends ShopState {
  final String message;

  ShopLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
