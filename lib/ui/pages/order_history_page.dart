part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;
  String status = '';

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoadedWithShop);

    status = selectedIndex == 0
        ? 'Baru'
        : selectedIndex == 1
            ? 'Diantar'
            : selectedIndex == 2
                ? 'Dibatalkan'
                : 'Selesai';
    if (context.watch<UserCubit>().state is UserLoadingFailed)
      return IllustrationPage(
        title: 'Gagal memuat!',
        sizeTitle: 20,
        subtitle:
            (context.watch<UserCubit>().state as UserLoadingFailed).message,
        picturePath: notFound,
      );
    else if (context.watch<UserCubit>().state is UserInitial)
      return IllustrationPage(
        title: 'Oops!',
        subtitle: notLogin,
        picturePath: protect,
        buttonTap1: () => Get.to(() => SignInPage()),
        buttonTitle1: 'Login',
      );
    else if (isLogin)
      return BlocBuilder<TransactionCubit, TransactionState>(
          builder: (_, state) {
        if (state is TransactionLoaded) {
          if (state.transactions.length == 0) {
            return IllustrationPage(
              title: 'Oops!',
              subtitle: 'Pesanan masih kosong\nbelum ada transaksi di tokomu',
              picturePath: loveBurger,
            );
          } else {
            double listItemWidth =
                MediaQuery.of(context).size.width - 2 * defaultMargin;
            List<Transaction> pending = state.transactions
                .where((element) => element.status == TransactionStatus.pending)
                .toList();
            int count = pending.length;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<TransactionCubit>().getTransactions(null, null);
              },
              child: ListView(
                children: [
                  TitlePage(
                      title: "Pesanan Toko",
                      subtitle:
                          'Daftar pesanan tokomu, silahkan\nklik untuk lihat detailnya',
                      isContainerRight: true,
                      press: () async {
                        await showDialog(
                            context: context,
                            builder: (_) =>
                                NotificationDialog(transactions: pending));
                      },
                      count: count,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            CustomTabBar(
                              titles: [
                                'Baru',
                                'Diantar',
                                'Dibatalkan',
                                'Selesai'
                              ],
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
                            Builder(builder: (_) {
                              List<Transaction> transactions = (selectedIndex ==
                                      0)
                                  ? state.transactions
                                      .where((element) =>
                                          element.status ==
                                          TransactionStatus.pending)
                                      .toList()
                                  : (selectedIndex == 1)
                                      ? state.transactions
                                          .where((element) =>
                                              element.status ==
                                              TransactionStatus.on_delivery)
                                          .toList()
                                      : (selectedIndex == 2)
                                          ? state.transactions
                                              .where((element) =>
                                                  element.status ==
                                                  TransactionStatus.cancelled)
                                              .toList()
                                          : state.transactions
                                              .where((element) =>
                                                  element.status ==
                                                  TransactionStatus.delivered)
                                              .toList();
                              if (transactions.length != 0) {
                                return Column(
                                  children: transactions
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: defaultMargin,
                                                left: defaultMargin,
                                                bottom: 16),
                                            child: OrderListItem(
                                                transaction: e,
                                                itemWidth: listItemWidth,
                                                press: () => Get.to(() =>
                                                    TransactionDetailsPage(
                                                        transaction: e))),
                                          ))
                                      .toList(),
                                );
                              } else {
                                return Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Illustration(
                                      picturePath: emptyTransaction,
                                      title: "Kosong",
                                      subtitle:
                                          "Pesanan di tokomu\ndengan status '" +
                                              status +
                                              "'\nmasih kosong",
                                    ),
                                  ],
                                );
                              }
                            }),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            );
          }
        } else if (state is TransactionLoadingFailed) {
          return IllustrationPage(
            title: 'Gagal memuat!',
            sizeTitle: 20,
            subtitle: state.message,
            picturePath: notFound,
          );
        } else {
          return Center(
            child: loadingIndicator,
          );
        }
      });
    else
      return loadingIndicator;
  }
}

class NotificationDialog extends StatelessWidget {
  final List<Transaction> transactions;

  NotificationDialog({this.transactions});

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;

    return Dialog(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Align(
                    alignment: Alignment.topRight,
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey,
                        child: InkWell(
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              )),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Column(children: [
            CustomIllustration(
                picturePath: emptyTransaction,
                title: "Pesanan Terbaru",
                isIllustration: false,
                sizeTitle: 20,
                subtitle: "Selesaikan pesanan Anda",
                sizeSubTitle: 15,
                marginBottom: 10),
            SizedBox(height: 15),
            transactions != null
                ? Container(
                    height: MediaQuery.of(context).size.height - 190,
                    child: SingleChildScrollView(
                      child: Column(
                        children: transactions
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: defaultMargin,
                                      left: defaultMargin,
                                      bottom: 16),
                                  child: OrderListItem(
                                      isDate: false,
                                      transaction: e,
                                      itemWidth: listItemWidth,
                                      press: () {
                                        Get.off(TransactionDetailsPage(
                                            transaction: e));
                                      }),
                                ))
                            .toList(),
                      ),
                    ))
                : SizedBox()
          ]),
        ],
      ),
    );
  }
}
