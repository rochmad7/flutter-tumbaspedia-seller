part of 'pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic> error;
  String message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onBackButtonPressed: () async {
        // await context.read<UserCubit>().getMyProfile(null);
        Get.back();
      },
      title: 'Lupa Password',
      subtitle: 'Reset Password Anda Melalui Email',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            message != null
                ? Column(
                    children: [
                      CustomAlert(
                          title: "Berhasil! \n" + message,
                          icon: MdiIcons.check,
                          type: 'success',
                          isDistance: false,
                          isCenter: false),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonDefault(
                          press: () => Get.to(() => SignInPage()),
                          title: "Lanjutkan Login",
                          color: mainColor),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelFormField(
                        label: "Anda Lupa Password?",
                      ),
                      Text(
                        "Anda lupa password akun Doltinuku? Tidak masalah. Anda hanya butuh mengisi email akun Doltinuku yang telah terdaftar, di kolom bawah ini dan kami akan mengirimkan link reset password ke email Anda. Selanjutnya Anda bisa me-reset password akun Anda",
                        style: blackFontStyle3.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LabelFormField(
                        label: "Email",
                      ),
                      TextFieldDefault(
                          icon: Icons.mail_outline,
                          controller: emailController,
                          hintText: "Email"),
                      TextDanger(error: error, param: "email"),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonDefault(
                        isLoading: isLoading,
                        title: "Reset Password",
                        press: () async {
                          setState(() {
                            isLoading = true;
                          });

                          // await context
                          //     .read<UserCubit>()
                          //     .forgotPassword(emailController.text);
                          UserState state = context.read<UserCubit>().state;

                          if (state is UserForgotPassword) {
                            setState(() {
                              error = null;
                              message = state.message;
                              isLoading = false;
                            });
                            snackBar(
                                "Berhasil",
                                "Link reset password berhasil dikirim",
                                'success');
                          } else {
                            // await context.read<UserCubit>().getMyProfile(null);
                            snackBar(
                                "Gagal",
                                (state as UserForgotPasswordFailed).message,
                                'error');
                            setState(() {
                              error = (state as UserForgotPasswordFailed)
                                          .error !=
                                      null
                                  ? (state as UserForgotPasswordFailed).error
                                  : null;
                              message = null;
                              isLoading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
