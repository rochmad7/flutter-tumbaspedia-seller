part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final User user;
  final String password;
  final Shop shop;

  SignUpPage({this.user, this.password, this.shop});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  User user;
  File pictureFile;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  // Initially password is obscure
  bool _obscureText = true;
  Map<String, dynamic> error;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    error = null;
    if (widget.user != null) {
      nameController.text = widget.user.name;
      emailController.text = widget.user.email;
      passwordController.text = widget.password;
      phoneController.text = widget.user.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Daftar',
      subtitle: 'Silahkan daftar akun toko baru',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            LabelFormField(
              label: "Nama Lengkap",
              isMandatory: true,
            ),
            TextFieldDefault(
                icon: Icons.person,
                controller: nameController,
                hintText: "Nama Lengkap"),
            TextDanger(error: error, param: "name"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
              label: "Email",
              isMandatory: true,
              example: "Contoh: tumbaspedia@gmail.com",
            ),
            TextFieldDefault(
                icon: Icons.mail_outline,
                controller: emailController,
                hintText: "Email"),
            TextDanger(error: error, param: "email"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
              label: "No. HP",
              isMandatory: true,
              example: "Contoh: 0888888888",
            ),
            TextFieldDefault(
                icon: MdiIcons.phone,
                controller: phoneController,
                hintText: "No. HP"),
            TextDanger(error: error, param: "phone"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
              label: "Password",
              isMandatory: true,
              example: "Minimal 6 karakter",
            ),
            TextFieldDefault(
                suffixIcon: () => _toggle(),
                icon: Icons.lock_outline,
                controller: passwordController,
                isObscureText: _obscureText,
                isSuffixIcon: true,
                hintText: "Password"),
            TextDanger(error: error, param: "password"),
            SizedBox(
              height: 5,
            ),
            Text("Tanda (*) wajib diisi",
                style: redFontStyle),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
                isLoading: isLoading,
                title: "Lanjutkan",
                press: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    snackBar("Gagal Melanjutkan", "Semua field harus diisi",
                        'error');

                    return;
                  }

                  if (!emailController.text.isEmail ||
                      !phoneController.text.isPhoneNumber ||
                      passwordController.text.length < 6) {
                    snackBar("Gagal Melanjutkan", "Format data tidak sesuai",
                        'error');
                    return;
                  }

                  User user = User(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                  );

                  setState(() {
                    isLoading = true;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();

                  // await context
                  //     .read<UserCubit>()
                  //     .checkUser(user, passwordController.text);
                  //
                  // UserState state = context.read<UserCubit>().state;
                  //
                  // if (state is UserLoaded) {
                  Get.off(AddShopPage(user: user, password: passwordController.text, shop: widget.shop));
                  // } else {
                  //   snackBar("Gagal Melanjutkan",
                  //       (state as UserLoadingFailed).message, 'error');
                  //
                  //   setState(() {
                  //     error = (state as UserLoadingFailed).error != null
                  //         ? (state as UserLoadingFailed).error
                  //         : null;
                  //     isLoading = false;
                  //   });
                  // }
                }),
            SizedBox(
              height: 25,
            ),
            TextUnderButton(
                title: "Sudah punya akun? ",
                subtitle: "Masuk",
                press: () => Get.to(
                      () => SignInPage(),
                    )),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
