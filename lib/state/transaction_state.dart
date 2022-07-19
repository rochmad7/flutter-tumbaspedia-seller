part of '../cubit/transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionLoadingFailed extends TransactionState {
  final String message;

  TransactionLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionUpdated extends TransactionState {
  // final Transaction transaction;
  final String message;

  TransactionUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class TransactionUpdateFailed extends TransactionState {
  final String message;

  TransactionUpdateFailed(this.message);

  @override
  List<Object> get props => [message];
}
