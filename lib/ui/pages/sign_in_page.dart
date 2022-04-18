part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Initially password is obscure
  bool _obscureText = true;
  Map<String, dynamic> error;
  List<dynamic> listError;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoLogIn();
    });

    super.initState();
  }

  void _autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('emailshop');
    final String password = prefs.getString('passwordshop');

    if (email != null) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Masuk',
      subtitle: 'Masuk menggunakan akun toko Anda',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo/ic_launcher.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldDefault(
                icon: Icons.mail_outline,
                controller: emailController,
                hintText: "Email"),
            TextDanger(error: error, param: "email"),
            SizedBox(
              height: 8,
            ),
            forgotPassword(),
            SizedBox(
              height: 7,
            ),
            TextFieldDefault(
                suffixIcon: () => _toggle(),
                icon: Icons.lock_outline,
                controller: passwordController,
                isObscureText: _obscureText,
                isSuffixIcon: true,
                hintText: "Password"),
            TextDanger(error: error, param: "password"),
            // ErrorValidation(error: error),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
              isLoading: isLoading,
              title: "Masuk",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                await context.read<UserCubit>().signIn(
                    emailController.text, passwordController.text, false);
                UserState state = context.read<UserCubit>().state;

                if (state is UserLoadedWithShop) {
                  context
                      .read<ProductCubit>()
                      .getMyProducts(null, null, null, null);
                  context.read<CategoryCubit>().getCategories(null);
                  context.read<UserCubit>().getMyProfile(state.shop);
                  context.read<TransactionCubit>().getTransactions(null);

                  User user =
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .user;
                  Shop shop =
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .shop;
                  (!shop.isReject)
                      ? (shop.nib != null)
                          ? (shop.isValid)
                              ? Get.offAll(() => MainPage(initialPage: 0))
                              : Get.offAll(() => WaitingShopPage(
                                  shopInitial: shop,
                                  userInitial: user,
                                  isReject: false))
                          : Get.offAll(() => SuccessSignInPage(
                              userInitial: user, shopInitial: shop))
                      : Get.offAll(() => WaitingShopPage(
                          shopInitial: shop,
                          userInitial: user,
                          isReject: true));
                } else {
                  snackBar("Maaf login gagal",
                      (state as UserLoadingFailed).message, 'error');
                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    isLoading = false;
                  });
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextUnderButton(
                title: "Belum punya akun? ",
                subtitle: "Daftar",
                press: () => Get.to(
                      () => SignUpPage(),
                    )),
          ],
        ),
      ),
    );
  }
}
