import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tumbaspedia_seller/models/models.dart';
import 'package:tumbaspedia_seller/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:tumbaspedia_seller/shared/shared.dart';

part '../state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> userInitial() async {
    emit(UserInitial());
  }

  Future<void> signIn(String email, String password) async {
    ApiReturnValueShop<User, Shop> result =
        await UserServices.signIn(email, password);

    if (result.error == null) {
      emit(UserLoadedWithShop(result.value, result.shop, result.token));
    } else {
      print('error: ${result.error}');
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> checkUser(User user, String password) async {
    ApiReturnValue<User> result = await UserServices.checkUser(user, password);

    if (result.value != null) {
      emit(UserLoaded(result.value, ""));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

  Future<void> signUp(User user, String password, Shop shop,
      {File pictureFile, File nibFile}) async {
    ApiReturnValueShop<User, Shop> result = await UserServices.signUp(
        user, password, shop,
        pictureFile: pictureFile, nibFile: nibFile);

    if (result.isException == false) {
      emit(UserLoadedWithShop(result.value, result.shop, result.token));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

// Future<void> forgotPassword(String email) async {
//   ApiReturnValue<bool> result = await UserServices.forgotPassword(email);
//
//   if (result.error == null && !result.isException) {
//     emit(UserForgotPassword(result.message, email));
//   } else {
//     emit(UserForgotPasswordFailed(result.message, result.error));
//   }
// }
//
  Future<void> changePassword(
      String oldPassword, String newPassword, String confPassword) async {
    ApiReturnValue<String> result = await UserServices.changePassword(
        oldPassword, newPassword, confPassword);

    if (result.isException == false) {
      emit(UserEdited(result.message));
    } else {
      emit(UserEditedFailed(result.message, result.error));
    }
  }

// Future<void> uploadShopPicture(
//     String token, File pictureFile, String urlPath) async {
//   ApiReturnValue<String> result =
//       await UserServices.uploadShopPicture(token, pictureFile, urlPath);
//
//   if (result.value != null) {
//     emit(UserLoadedWithShop(
//         (state as UserLoadedWithShop).user,
//         (state as UserLoadedWithShop)
//             .shop
//             .copyWith(images: baseURL + "storage/" + result.value)));
//   }
// }

/////// OLD ///////
// Future<void> getMyProfile() async {
//   ApiReturnValueShop<User, Shop> result = await UserServices.getMyProfile();

//   if (result.value != null && result.shop != null) {
//     emit(UserLoadedWithShop(result.value, result.shop));
//   } else {
//     emit(UserLoadingFailed(result.message));
//   }
// }

  Future<void> getMyProfile(Shop shop) async {
    ApiReturnValueShop<User, Shop> result =
        await UserServices.getMyProfile(shop);

    if (result.value != null && result.shop != null) {
      emit(UserLoadedWithShop(result.value, result.shop, result.token));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

// Future<void> addNib(User user, Shop shop, {File pictureFile}) async {
//   ApiReturnValueShop<User, Shop> result =
//       await UserServices.addNib(user, shop, pictureFile: pictureFile);
//   if (result.value != null && result.shop != null) {
//     emit(UserLoadedWithShop(result.value, result.shop));
//   } else {
//     emit(UserLoadingFailed(result.message, result.error));
//   }
// }

  Future<void> update(Shop shop, {File pictureFile}) async {
    ApiReturnValue<String> result =
        await UserServices.update(shop, pictureFile: pictureFile);

    if (result.isException != null || result.error != null) {
      emit(UserEdited(result.message));
    } else {
      emit(UserEditedFailed(result.message, result.error));
    }
  }

// Future<void> updateShopPicture(Shop shop, File pictureFile) async {
//   ApiReturnValue<String> result =
//       await UserServices.updateShopPicture(shop, pictureFile);
//
//   if (result.value != null) {
//     emit(UserLoadedWithShop(
//         (state as UserLoadedWithShop).user,
//         (state as UserLoadedWithShop)
//             .shop
//             .copyWith(images: baseURL + "storage/" + result.value)));
//   }
// }

  Future<void> changeStatus(bool status, int shopId) async {
    ApiReturnValueShop<User, Shop> result =
        await UserServices.changeStatus(status, shopId);

    if (result.value != null && result.shop != null) {
      emit(UserLoadedWithShop(result.value, result.shop, result.token));
    } else {
      emit(UserLoadingFailed(result.message, result.error));
    }
  }

// Future<void> logOut() async {
//   await UserServices.logOut();
// }
// }
}
