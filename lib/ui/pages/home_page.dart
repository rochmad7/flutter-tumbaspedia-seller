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
        if (state is UserLoadingFailed) {
          return IllustrationPage(
            title: 'Gagal memuat!',
            sizeTitle: 20,
            subtitle: state.message,
            picturePath: notFound,
          );
        } else if (state is UserLoadedWithShop) {
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
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                        // color: Colors.white,
                        height: 70,
                        width: 270,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/logo/home_logo.png',
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
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
                      // FeaturedRow(shop: state.shop),
                      UserInfo(user: state.user),
                      ShopInfo(shop: state.shop),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ));
        } else {
          return loadingIndicator;
        }
      },
    );
  }
}

class FeaturedRow extends StatelessWidget {
  final Shop shop;

  FeaturedRow({this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jadwal Toko",
                style: blackFontStyle1.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 14.0,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "${shop.openingHours.substring(0, 5)} - ${shop.closedHours.substring(0, 5)}",
                    style: blackFontStyle2,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.green,
            ),
            child: Text(
              shop.status ? "Buka" : "Tutup",
              style: whiteFontStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
                    child: Icon(icon, color: Colors.white, size: 20)),
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
                        child: Text(title, style: whiteFontStyle)))
              ],
            ),
          ),
        ));
  }
}
