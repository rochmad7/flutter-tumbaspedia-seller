part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoadedWithShop);
    User user = isLogin
        ? (context.watch<UserCubit>().state as UserLoadedWithShop).user
        : null;
    Shop shop = isLogin
        ? (context.watch<UserCubit>().state as UserLoadedWithShop).shop
        : null;
    return ListView(
      children: [
        Column(
          children: [
            //// Header
            isLogin
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    height: 220,
                    margin: EdgeInsets.only(bottom: defaultMargin),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(10),
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage(
                          //             'assets/images/user/photo_border.png'))),
                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                ),
                              ),
                            ),
                            imageUrl:
                                "https://ui-avatars.com/api/?name=" + shop.name,
                            fit: BoxFit.cover,
                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            repeat: ImageRepeat.repeat,
                          ),
                        ),
                        Text(
                          shop.name,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          user.name,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  )
                : TitlePage(
                    title: "Pengaturan",
                    subtitle: "Pengaturan Akun Toko Doltinuku",
                    isContainer: true),
            //// Body
            Container(
              width: double.infinity,
              color: Colors.white,
              child: isLogin
                  ? Column(
                      children: [
                        CustomTabBar(
                          titles: ["Toko", "Shop Doltinuku"],
                          selectedIndex: selectedIndex,
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: ((selectedIndex == 0)
                                  ? [
                                      {
                                        'name': 'Edit Toko',
                                        'press': EditShopPage(
                                            shop: shop, user: user),
                                      },
                                      {
                                        'name': 'Ganti Password',
                                        'press': ChangePasswordPage(
                                            user: user, shop: shop)
                                      },
                                    ]
                                  : [
                                      {
                                        'name': 'Tentang Kami',
                                        'press': AboutPage()
                                      },
                                      {
                                        'name': 'Bantuan',
                                        'press': HelpPage(),
                                      },
                                      {
                                        'name': 'Kebijakan Privasi',
                                        'press': PrivacyPage(),
                                      },
                                    ])
                              .map((e) => GestureDetector(
                                  onTap: () => Get.to(e['press']),
                                  child: SettingTitle(title: e['name'])))
                              .toList(),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await context.read<UserCubit>().logOut();

                            Get.offAll(() => SignInPage());
                            snackBar("Berhasil", "Anda telah berhasil logout",
                                'success');
                          },
                          child: Column(
                            children: [
                              SettingTitle(
                                title: "Log Out",
                                isCustomStyle: true,
                                style: GoogleFonts.poppins(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            {'name': 'Login', 'press': SignInPage()},
                            {'name': 'Daftar Toko Baru', 'press': SignUpPage()},
                            {
                              'name': 'Lupa Password',
                              'press': ForgotPasswordPage()
                            },
                            {'name': 'Tentang Kami', 'press': AboutPage()},
                            {'name': 'Bantuan', 'press': HelpPage()},
                            {
                              'name': 'Kebijakan Privasi',
                              'press': PrivacyPage()
                            },
                          ]
                              .map((e) => GestureDetector(
                                    onTap: () => Get.to(e['press']),
                                    child: SettingTitle(title: e['name']),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 10),
            Center(child: Text("Versi 2.1.3", style: blackFontStyle)),
          ],
        ),
      ],
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  final bool isCustomStyle;
  final TextStyle style;
  SettingTitle({this.title, this.isCustomStyle = false, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16, left: defaultMargin, right: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isCustomStyle ? style : blackFontStyle3,
          ),
          SizedBox(
            height: defaultMargin,
            width: defaultMargin,
            child: Image.asset(
              'assets/icons/right_arrow.png',
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
