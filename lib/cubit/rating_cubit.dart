import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:shop_tumbaspedia/models/models.dart';
import 'package:shop_tumbaspedia/services/services.dart';

part '../state/rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  Future<void> getRatings(
      int start, int limit, int productId, int userId) async {
    ApiReturnValue<List<Rating>> result =
        await RatingServices.getRatings(start, limit, productId, userId);

    if (result.value != null) {
      emit(RatingLoaded(ratings: result.value));
    } else {
      emit(RatingLoadingFailed(result.message));
    }
  }
}
