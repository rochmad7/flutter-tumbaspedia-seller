import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumbaspedia_seller/models/models.dart';
import 'package:tumbaspedia_seller/services/services.dart';

part '../state/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> getTransactions(int limit, String token) async {
    ApiReturnValue<List<Transaction>> result =
        await TransactionServices.getTransactions(limit, token);

    if (result.value != null) {
      emit(TransactionLoaded(result.value));
    } else {
      emit(TransactionLoadingFailed(result.message));
    }
  }

  Future<void> updateTransaction(
      Transaction transaction, TransactionStatus status) async {
    ApiReturnValue<String> result =
        await TransactionServices.updateTransactionStatus(transaction, status);

    if (result.isException == false) {
      emit(TransactionUpdated(result.message));
      // return result.value;
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
