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
                    height: 300,
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
                            imageUrl: shop.images,
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
                          style: GoogleFonts.roboto(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          user.name,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          user.email,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          user.phoneNumber,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          shop.address,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          shop.description,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : TitlePage(
                    title: "Pengaturan",
                    subtitle: "Pengaturan Akun Toko Tumbaspedia",
                    isContainer: true),
            //// Body
            Container(
              width: double.infinity,
              color: Colors.white,
              child: isLogin
                  ? Column(
                      children: [
                        // CustomTabBar(
                        //   titles: ["Toko", "Shop Tumbaspedia"],
                        //   selectedIndex: selectedIndex,
                        //   onTap: (index) {
                        //     setState(() {
                        //       selectedIndex = index;
                        //     });
                        //   },
                        // ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            {
                              'name': 'Edit Toko',
                              'press': EditShopPage(shop: shop, user: user),
                            },
                            {
                              'name': 'Ubah Kata Sandi',
                              'press':
                                  ChangePasswordPage(user: user, shop: shop)
                            },
                            {'name': 'Tentang Kami', 'press': AboutPage()},
                            {
                              'name': 'Bantuan',
                              'press': HelpPage(),
                            },
                            // {
                            //   'name': 'Kebijakan Privasi',
                            //   'press': PrivacyPage(),
                            // },
                          ]
                              .map((e) => GestureDetector(
                                  onTap: () => Get.to(e['press']),
                                  child: SettingTitle(title: e['name'])))
                              .toList(),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await context.read<UserCubit>().logOut();

                            Get.offAll(() => SignInPage());
                            snackBar("Berhasil", "Anda telah berhasil keluar",
                                'success');
                          },
                          child: Column(
                            children: [
                              SettingTitle(
                                title: "Keluar",
                                isCustomStyle: true,
                                style: GoogleFonts.roboto(
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
                            {'name': 'Masuk', 'press': SignInPage()},
                            {'name': 'Daftar Toko Baru', 'press': SignUpPage()},
                            {
                              'name': 'Lupa Kata Sandi',
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            launch("https://www.facebook.com/profile.php?id=100069886188294&mibextid=ZbWKwL");
                          },
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.squareFacebook,
                              ),
                              Text(
                                " Gerai Kopimi Rowosari",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {
                              launch("https://instagram.com/paguyubanumkmrowosari_semarang");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.pink,
                                ),
                                Text(
                                  " paguyubanumkmrowosari_semarang",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.pink),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ),
            // SizedBox(height: 10),
            // Center(child: Text("Versi 1.0", style: blackFontStyle)),
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
          bottom: 8, left: defaultMargin, right: defaultMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isCustomStyle ? style : blackFontStyle3.copyWith(
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(
                child: Icon(Icons.arrow_forward_ios, size: 12
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
