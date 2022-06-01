import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:shop_tumbaspedia/services/services.dart';
import 'package:shop_tumbaspedia/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_tumbaspedia/shared/shared.dart';

part '../state/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getMyProducts(
      String query, int start, int limit, int categoryId) async {
    ApiReturnValue<List<Product>> result = await ProductServices.getMyProducts(
        query, start, limit, categoryId, null);

    if (result.value != null) {
      emit(ProductLoaded(result.value));
    } else {
      emit(ProductLoadingFailed(result.message, result.error));
    }
  }

  /////////// CRUD ////////////
  Future<void> store(Product product, Shop shop, {File pictureFile}) async {
    // await ProductServices.store(product, shop);
    ApiReturnValue<String> result =
        await ProductServices.store(product, shop, pictureFile: pictureFile);

    if (result.error != null) {
      emit(ProductAddedFailed(result.message, result.error));
    } else {
      emit(ProductAdded(result.message));
    }
  }

  // Future<void> edit(Product product) async {
  //   ApiReturnValue<Product> result = await ProductServices.edit(product);

  //   if (result.value != null) {
  //     emit(ProductFetch(result.value));
  //   } else {
  //     emit(ProductFetchFailed(result.message));
  //   }
  // }

  Future<void> update(Product product, {File pictureFile}) async {
    ApiReturnValue<String> result =
        await ProductServices.update(product, pictureFile: pictureFile);

    if (result.error != null) {
      emit(ProductEditedFailed(result.message, result.error));
    } else {
      emit(ProductEdited(result.message));
    }
  }

  // Future<void> uploadProductPicture(Product product, File pictureFile) async {
  //   ApiReturnValue<String> result =
  //       await ProductServices.uploadProductPicture(product, pictureFile);
  //
  //   if (result.value != null) {
  //     emit(ProductAdded((state as ProductAdded)
  //         .product
  //         .copyWith(images: baseURL + "storage/" + result.value)));
  //   }
  // }

  // Future<void> updateProductPicture(Product product, File pictureFile) async {
  //   ApiReturnValue<String> result =
  //       await ProductServices.updateProductPicture(product, pictureFile);
  //
  //   if (result.value != null) {
  //     emit(ProductEdited((state as ProductEdited)
  //         .product
  //         .copyWith(images: baseURL + "storage/" + result.value)));
  //   }
  // }

  Future<void> destroy(Product product) async {
    ApiReturnValue<String> result = await ProductServices.destroy(product);

    if (result.value != null) {
      emit(ProductDeleted(result.message));
    } else {
      emit(ProductDeletedFailed(result.message, result.error));
    }
  }
}
