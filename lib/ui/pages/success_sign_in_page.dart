part of 'pages.dart';

class SuccessSignInPage extends StatelessWidget {
  final Shop shopInitial;
  final User userInitial;
  SuccessSignInPage({this.shopInitial, this.userInitial});
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
              isBackHome: true,
              title: 'Gagal memuat!',
              sizeTitle: 20,
              subtitle: state.message,
              picturePath: notFound,
            ),
          );
        else if (state is UserLoadedWithShop) {
          shop ??= state.shop;
          user ??= state.user;
          return Scaffold(
              backgroundColor: Colors.white,
              body: IllustrationPage(
                isBackHome: true,
                title: "Yeay! Berhasil",
                subtitle:
                    "Yuk lengkapi tokomu\ndengan mengupload NIB\n(Nomor Induk Berusaha)",
                picturePath: completeProfile,
                buttonTap1: () =>
                    Get.to(() => AddNibPage(user: user, shop: shop)),
                buttonTitle1: 'Lengkapi Data Toko',
              ));
        } else
          return Scaffold(
              backgroundColor: Colors.white, body: loadingIndicator);
      },
    );
  }
}
