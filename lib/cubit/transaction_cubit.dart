import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_tumbaspedia/models/models.dart';
import 'package:shop_tumbaspedia/services/services.dart';

part '../state/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> getTransactions(int limit, int shopId) async {
    ApiReturnValue<List<Transaction>> result =
        await TransactionServices.getTransactions(limit, shopId);

    if (result.value != null) {
      emit(TransactionLoaded(result.value));
    } else {
      emit(TransactionLoadingFailed(result.message));
    }
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    ApiReturnValue<Transaction> result =
        await TransactionServices.updateTransaction(transaction);

    if (result.value != null) {
      emit(TransactionUpdated(result.value));
      return result.value;
    } else {
      emit(TransactionUpdateFailed(result.message));
      return null;
    }
  }

  // Future<String> submitTransaction(Transaction transaction) async {
  //   ApiReturnValue<Transaction> result =
  //       await TransactionServices.submitTransaction(transaction);

  //   if (result.value != null) {
  //     emit(TransactionLoaded(
  //         (state as TransactionLoaded).transactions + [result.value]));
  //     return result.value.paymentUrl;
  //   } else {
  //     return null;
  //   }
  // }
}
