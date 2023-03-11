part of 'widgets.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  CustomBottomNavbar({this.selectedIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 0, right: 0),
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff541690),
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconBottomNavbar(
              selectedIndex: selectedIndex,
              index: 0,
              icon: MdiIcons.home,
              title: "Beranda",
              onTap: onTap),
          IconBottomNavbar(
              selectedIndex: selectedIndex,
              index: 1,
              icon: MdiIcons.shopping,
              title: "Produk",
              marginHorizontal: 10,
              onTap: onTap),
          IconBottomNavbar(
              selectedIndex: selectedIndex,
              index: 2,
              icon: Icons.add_circle,
              title: "Tambah",
              onTap: onTap),
          IconBottomNavbar(
              selectedIndex: selectedIndex,
              index: 3,
              icon: MdiIcons.cart,
              title: "Pesanan",
              marginHorizontal: 10,
              onTap: onTap),
          IconBottomNavbar(
              selectedIndex: selectedIndex,
              index: 4,
              icon: MdiIcons.account,
              title: "Akun",
              onTap: onTap),
        ],
      ),
    );
  }
}

class IconBottomNavbar extends StatelessWidget {
  final double marginHorizontal;
  final int selectedIndex;
  final String title;
  final Function(int index) onTap;
  final int index;
  final IconData icon;
  IconBottomNavbar(
      {this.title,
      this.marginHorizontal = 0,
      this.selectedIndex = 0,
      this.icon,
      this.index,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap(index);
        }
      },
      child: Container(
        width: 60,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Icon(icon,
                    size: 26,
                    color: (selectedIndex == index) ? Colors.orange : Colors.white70),
                Text(
                  title,
                  style: blackFontStyle2.copyWith(
                      fontSize: 13,
                      color:
                          (selectedIndex == index) ? Colors.orange : Colors.white70),
                ),
              ],
            ),
            index == 3
                ? (context.watch<UserCubit>().state is UserLoadedWithShop)
                    ? BlocBuilder<TransactionCubit, TransactionState>(
                        builder: (_, state) => (state is TransactionLoaded)
                            ? (state.transactions
                                        .where((element) =>
                                            element.status ==
                                            TransactionStatus.pending)
                                        .toList()
                                        .length !=
                                    0)
                                ? Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      alignment: Alignment.center,
                                      child: Text(
                                          state.transactions
                                              .where((element) =>
                                                  element.status ==
                                                  TransactionStatus.pending)
                                              .toList()
                                              .length
                                              .toString(),
                                          style: whiteFontStyle3.copyWith(
                                              fontSize: 10)),
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox())
                    : SizedBox()
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
