import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_tumbaspedia/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/pages.dart';
// import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String password = prefs.getString('passwordshop') ?? '';
  // String email = prefs.getString('emailshop') ?? '';
  // String token = prefs.getString('tokenshop') ?? '';
  // String nib = prefs.getString('nib') ?? '';
  // bool isReject = prefs.getBool('isReject') ?? false;
  // bool isValid = prefs.getBool('isValid') ?? false;

  final _storage = const FlutterSecureStorage();
  String token = await _storage.read(key: 'token');
  String email = await _storage.read(key: 'email');
  String password = await _storage.read(key: 'password');

  runApp(MyApp(email: email, password: password, token: token));
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final String email;
  final String password;
  final String token;
  final String nib;
  final bool isReject;
  final bool isValid;

  MyApp(
      {this.email = '',
      this.password = '',
      this.token = '',
      this.nib = '',
      this.isReject = false,
      this.isValid = false});

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
          // BlocProvider(create: (_) => PhotoCubit()),
          // BlocProvider(create: (_) => RatingCubit()),
        ],
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Shop Tumbaspedia",
            home: email == '' && password == '' && token == ''
                ? SignInPage()
                : MainPage(initialPage: 0))
        // : WaitingShopPage(
        //     shopInitial: null, userInitial: null, isReject: false)),
        );
  }
}
