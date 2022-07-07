part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  int count = 9;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (_, state) {
        if (state is UserLoadingFailed)
          return IllustrationPage(
            title: 'Gagal memuat!',
            sizeTitle: 20,
            subtitle: state.message,
            picturePath: notFound,
          );
        else if (state is UserLoadedWithShop)
          return Scaffold(
              backgroundColor: Colors.grey.shade100,
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: RefreshIndicator(
                onRefresh: () async {
                  await context.read<UserCubit>().getMyProfile(
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .shop);
                  await context
                      .read<ProductCubit>()
                      .getMyProducts(null, null, null, null);
                  await context
                      .read<TransactionCubit>()
                      .getTransactions(null, state.token);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ProfileHeader(
                        shopId: state.shop.id,
                        status: state.shop.status,
                        shopOpenHours: state.shop.openingHours,
                        shopClosedHours: state.shop.closedHours,
                        avatar: NetworkImage(state.shop.images),
                        coverImage: NetworkImage(state.shop.images),
                        title: state.shop.name,
                        actions: <Widget>[
                          MaterialButton(
                            color: Colors.white,
                            shape: CircleBorder(),
                            elevation: 0,
                            child: Icon(Icons.edit),
                            onPressed: () => Get.to(() => EditShopPage(
                                shop: (context.read<UserCubit>().state
                                        as UserLoadedWithShop)
                                    .shop,
                                user: (context.read<UserCubit>().state
                                        as UserLoadedWithShop)
                                    .user)),
                          )
                        ],
                      ),
                      FeaturedRow(shop: state.shop),
                      UserInfo(user: state.user),
                      ShopInfo(shop: state.shop),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ));
        else
          return loadingIndicator;
      },
    );
  }
}

class FeaturedRow extends StatelessWidget {
  final Shop shop;

  FeaturedRow({this.shop});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // CustomCard(
            //   startColor: "#000428".toColor(),
            //   endColor: "#004e92".toColor(),
            //   icon: MdiIcons.shopping,
            //   title: "Total Produk",
            //   // count: shop.totalProducts,
            // ),
            // CustomCard(
            //   startColor: "#42275a".toColor(),
            //   endColor: "#734b6d".toColor(),
            //   icon: MdiIcons.cart,
            //   title: "Produk Terjual",
            //   // count: shop.sold,
            // ),
            // CustomCard(
            //   isPrice: true,
            //   startColor: "#ff512f".toColor(),
            //   endColor: "#dd2476".toColor(),
            //   icon: MdiIcons.cashMultiple,
            //   title: "Pendapatan",
            //   // count: shop.income,
            // ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final bool isPrice;
  final String title;
  final Color startColor;
  final Color endColor;
  final int count;

  CustomCard(
      {this.icon,
      this.isPrice = false,
      this.title,
      this.startColor,
      this.endColor,
      this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: MediaQuery.of(context).size.width * .44,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  startColor,
                  endColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            color: Colors.redAccent.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Colors.purple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    )),
                Center(
                    child: Text(
                  isPrice
                      ? getFormatRupiah(count, true)
                      : numberFormatDecimal(count),
                  style: whiteFontStyle1,
                )),
                Positioned(
                  bottom: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .44,
                    alignment: Alignment.topCenter,
                    child: Text(title, style: whiteFontStyle),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
