part of 'pages.dart';

class SuccessSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IllustrationPage(
          title: "Yeay! Berhasil",
          subtitle:
              "Akun toko telah berhasil dibuat\nsilahkan kelola toko Anda",
          picturePath: shopIllustration,
          buttonTap1: () {
            Get.offAll(() => MainPage());
          },
          buttonTitle1: 'Kelola Toko UKM',
        ));
  }
}
