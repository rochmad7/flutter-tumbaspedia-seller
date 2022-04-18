import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_tumbaspedia/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/pages.dart';
// import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String password = prefs.getString('passwordshop') ?? '';
  String email = prefs.getString('emailshop') ?? '';
  String token = prefs.getString('tokenshop') ?? '';
  String nib = prefs.getString('nib') ?? '';
  bool isReject = prefs.getBool('isReject') ?? false;
  bool isValid = prefs.getBool('isValid') ?? false;
  runApp(MyApp(
      email: email,
      password: password,
      token: token,
      isValid: isValid,
      isReject: isReject,
      nib: nib));
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
                create: (_) => UserCubit()..signIn(email, password, true)),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => ShopCubit()),
        email == '' && password == '' && token == ''
            ? BlocProvider(create: (_) => TransactionCubit())
            : BlocProvider(
                create: (_) => TransactionCubit()..getTransactions(null)),
        BlocProvider(create: (_) => PhotoCubit()),
        BlocProvider(create: (_) => RatingCubit()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shop Tumbaspedia",
          home: email == '' && password == '' && token == ''
              ? SignInPage()
              : (!isReject)
                  ? (nib != '')
                      ? (isValid)
                          ? MainPage(initialPage: 0)
                          : WaitingShopPage(
                              shopInitial: null,
                              userInitial: null,
                              isReject: false)
                      : SuccessSignInPage(userInitial: null, shopInitial: null)
                  : WaitingShopPage(
                      shopInitial: null, userInitial: null, isReject: true)),
    );
  }
}
