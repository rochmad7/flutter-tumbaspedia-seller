part of 'pages.dart';

class WaitingShopPage extends StatelessWidget {
  final Shop shopInitial;
  final User userInitial;
  final bool isReject;
  WaitingShopPage({this.shopInitial, this.userInitial, this.isReject = false});
  @override
  Widget build(BuildContext context) {
    Shop shop = shopInitial;
    User user = userInitial;

    return BlocBuilder<UserCubit, UserState>(
      builder: (_, state) {
        if (state is UserLoadingFailed)
          return Scaffold(
            backgroundColor: Colors.white,
            body: IllustrationPage(
              title: 'Gagal memuat!',
              sizeTitle: 20,
              subtitle: state.message,
              picturePath: notFound,
            ),
          );
        else if (state is UserLoadedWithShop) {
          shop ??= state.shop;
          user ??= state.user;
          if (isReject) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: IllustrationPage(
                  title: "Oops, Maaf",
                  isBackHome: true,
                  subtitle: "Sayangnya toko Anda\nyaitu (toko " +
                      shop.name +
                      ")\ntidak lolos proses verifikasi oleh\ntim Doltinuku & Pengurus UKM\nGerai Kopimi Gedawang",
                  picturePath: protect,
                  buttonTap1: () async => await launch(
                      "mailto:doltinukuid@gmail.com?Subject=Pendaftaran%20Akun%20Toko%20Gagal"),
                  buttonTitle1: "Hubungi Tumbaspedia",
                ));
          } else {
            return Scaffold(
                backgroundColor: Colors.white,
                body: IllustrationPage(
                  title: (shop.isValid) ? "Hore" : "Harap Bersabar Ya",
                  isBackHome: (shop.isValid) ? false : true,
                  sizeTitle: (shop.isValid) ? 24 : 20,
                  subtitle: (shop.isValid)
                      ? "Toko Anda (toko " +
                          shop.name +
                          ") \ntelah lolos proses verifikasi \ntim Doltinuku. Silahkan\nmulai kelola toko Anda"
                      : "Berkas Anda telah diterima\ntetapi toko Anda (toko " +
                          shop.name +
                          ")\n sedang diverifikasi\noleh tim Tumbaspedia",
                  picturePath: (shop.isValid) ? shopIllustration : verification,
                  buttonTap1: (shop.isValid)
                      ? () {
                          Get.offAll(() => MainPage(initialPage: 0));
                        }
                      : () async => await launch(
                          "mailto:doltinukuid@gmail.com?Subject=Menunggu%20Verifikasi%20Akun%20Toko"),
                  buttonTitle1: (shop.isValid)
                      ? 'Mulai kelola toko'
                      : "Hubungi Tumbaspedia",
                ));
          }
        } else
          return Scaffold(
              backgroundColor: Colors.white, body: loadingIndicator);
      },
    );
  }
}
