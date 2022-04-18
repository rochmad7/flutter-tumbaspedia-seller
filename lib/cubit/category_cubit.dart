import 'package:bloc/bloc.dart';
import 'package:shop_tumbaspedia/services/services.dart';
import 'package:shop_tumbaspedia/models/models.dart';
import 'package:equatable/equatable.dart';

part '../state/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategories(int limit) async {
    ApiReturnValue<List<Category>> result =
        await CategoryServices.getCategories(limit);

    if (result.value != null) {
      emit(CategoryLoaded(result.value));
    } else {
      emit(CategoryLoadingFailed(result.message));
    }
  }
}
