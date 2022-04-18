import 'package:bloc/bloc.dart';
import 'package:shop_tumbaspedia/models/models.dart';
// import 'package:shop_tumbaspedia/services/services.dart';
import 'package:equatable/equatable.dart';

part '../state/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  // Future<void> getDataShop() async {
  //   ApiReturnValue<Shop> result = await ShopServices.getDataShop();

  //   if (result.value != null) {
  //     emit(ShopLoaded(result.value));
  //   } else {
  //     emit(ShopLoadingFailed(result.message));
  //   }
  // }
}
