import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tumbaspedia_seller/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tumbaspedia_seller/shared/shared.dart';

import 'ui/pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  final _storage = const FlutterSecureStorage();
  String token = await _storage.read(key: 'shop_token') ?? '';
  String email = await _storage.read(key: 'shop_email') ?? '';
  String password = await _storage.read(key: 'shop_password') ?? '';

  String tumbaspediaDefinition = await fetchStaticData();

  runApp(MyApp(email: email, password: password, token: token, tumbaspediaDefinition: tumbaspediaDefinition,));
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final String email;
  final String password;
  final String token;
  final String tumbaspediaDefinition;

  MyApp(
      {this.email,
      this.password,
      this.token,
      this.tumbaspediaDefinition
      });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          email == '' && password == '' && token == ''
              ? BlocProvider(create: (_) => UserCubit()..userInitial())
              : BlocProvider(
                  create: (_) => UserCubit()..signIn(email, password)),
          BlocProvider(create: (_) => ProductCubit()),
          BlocProvider(create: (_) => CategoryCubit()),
          BlocProvider(create: (_) => ShopCubit()),
          email == '' && password == '' && token == ''
              ? BlocProvider(create: (_) => TransactionCubit())
              : BlocProvider(
                  create: (_) =>
                      TransactionCubit()..getTransactions(null, token)),
          BlocProvider(create: (_) => PhotoCubit()),
          // BlocProvider(create: (_) => RatingCubit()),
        ],
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Shop Tumbaspedia",
            home: email == '' && password == '' && token == ''
                ? SignInPage()
                : MainPage(initialPage: 0, tumbaspediaDefinition: tumbaspediaDefinition,))
        // : WaitingShopPage(
        //     shopInitial: null, userInitial: null, isReject: false)),
        );
  }
}
