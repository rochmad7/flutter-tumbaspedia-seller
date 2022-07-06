import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:shop_tumbaspedia/models/models.dart';
import 'package:shop_tumbaspedia/services/services.dart';

part '../state/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoInitial());

  Future<void> getPhotos(int start, int limit, int productId) async {
    ApiReturnValue<List<Photo>> result =
        await PhotoServices.getPhotos(start, limit, productId);

    if (result.value != null) {
      emit(PhotoLoaded(photos: result.value));
    } else {
      emit(PhotoLoadingFailed(result.message));
    }
  }

  Future<void> getPhotosByProduct(Product product) async {
    ApiReturnValue<List<Photo>> result =
        await PhotoServices.getPhotosByProduct(product);

    if (result.value != null) {
      emit(PhotosByProductLoaded(photos: result.value));
    } else {
      emit(PhotoLoadingFailed(result.message));
    }
  }

  Future<void> uploadMultiple(int productId,
      {List<Object> picturesFile}) async {
    ApiReturnValue<String> result = await PhotoServices.uploadMultiple(
        productId,
        picturesFile: picturesFile);

    if (result.isException == false) {
      emit(PhotoAdded(result.message));
    } else {
      emit(PhotoAddedFailed(result.message, result.error));
    }
  }

  Future<void> destroyMultiple(Product product, bool isAll) async {
    ApiReturnValue<String> result =
        await PhotoServices.destroyMultiple(product, isAll);

    if (result.value != null) {
      emit(PhotoDeleted(result.message));
    } else {
      emit(PhotoDeletedFailed(result.message, result.error));
    }
  }
}
