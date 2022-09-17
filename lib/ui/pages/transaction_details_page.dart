part of 'pages.dart';

class TransactionDetailsPage extends StatefulWidget {
  final Transaction transaction;

  TransactionDetailsPage({this.transaction});

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Pesanan Toko',
      subtitle: 'Detail pesanan toko Anda',
      onBackButtonPressed: () {
        Get.back();
      },
      backColor: 'FAFAFC'.toColor(),
      child: Column(
        children: [
          //// Bagian atas
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan [ID: ' + widget.transaction.id.toString() + "]",
                  style: titleListStyle,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          imageUrl: widget.transaction.product.images,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          repeat: ImageRepeat.repeat,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 198,
                              // 2 * defaultMargin (jarak border) +
                              // 60 (lebar picture) +
                              // 12 (jarak picture ke title)+
                              // 78 (lebar jumlah items),
                              child: Text(
                                widget.transaction.product.name,
                                style: blackFontStyle2,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              getFormatRupiah(
                                  (widget.transaction.product.price).round(), true),
                              style: textListStyle.copyWith(fontSize: 13),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${widget.transaction.quantity} item(s)',
                      style: textListStyle.copyWith(fontSize: 13),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                TitleList(title: "Status Pesanan"),
                ItemList(
                    title: "Tanggal",
                    subtitle: convertDate(widget.transaction.dateTime, false)),
                SizedBox(
                  height: 6,
                ),
                ItemList(
                    title: "Waktu",
                    subtitle: convertTime(widget.transaction.dateTime)),
                SizedBox(
                  height: 6,
                ),
                ItemList(
                  title: "Status",
                  customSubtitle: (widget.transaction.status ==
                          TransactionStatus.cancelled)
                      ? Text(
                          'Dibatalkan',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(color: 'D9435E'.toColor()),
                        )
                      : (widget.transaction.status == TransactionStatus.pending)
                          ? Text(
                              'Pesanan Baru',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                  color: 'D9435E'.toColor()),
                            )
                          : (widget.transaction.status ==
                                  TransactionStatus.on_delivery)
                              ? Text(
                                  'Sedang Diantar',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      color: "#128C7E".toColor()),
                                )
                              : Text(
                                  'Pesanan Selesai',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      color: "#128C7E".toColor()),
                                ),
                ),
                SizedBox(
                  height: 6,
                ),
                TitleList(title: "Detail Pesanan"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          widget.transaction.product.name,
                          style: textListStyle.copyWith(fontSize: 14),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          getFormatRupiah(widget.transaction.product.price, true),
                          style: blackFontStyle3,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          'Total',
                          style: textListStyle.copyWith(fontSize: 14),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          getFormatRupiah(
                              (widget.transaction.total).round(), true),
                          style: titleListStyle,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
              ],
            ),
          ),
          //// Bagian bawah
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dipesan oleh',
                  style: titleListStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                ItemList(title: "Nama", subtitle: widget.transaction.user.name),
                SizedBox(
                  height: 6,
                ),
                ItemList(
                    title: "No HP",
                    subtitle: widget.transaction.user.phoneNumber),
                SizedBox(
                  height: 6,
                ),
                ItemList(
                    title: "Alamat", subtitle: widget.transaction.user.address),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          ButtonIconDefault(
              title: "Hubungi Pembeli",
              color: "#128C7E".toColor(),
              press: () async => await launch("https://wa.me/62" +
                  widget.transaction.user.phoneNumber.allAfter("0")),
              icon: MdiIcons.whatsapp),
          SizedBox(
            height: 10,
          ),
          (widget.transaction.status != TransactionStatus.delivered &&
                  widget.transaction.status != TransactionStatus.on_delivery)
              ? ButtonIconDefault(
                  title: "Edit Pesanan",
                  press: () => Get.to(() =>
                      EditTransactionPage(transaction: widget.transaction)),
                  icon: Icons.edit)
              : SizedBox(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class TitleList extends StatelessWidget {
  final String title;
  TitleList({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: titleListStyle,
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget customSubtitle;
  ItemList({this.title, this.subtitle, this.customSubtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 80,
              child: Text(
                title,
                style: textListStyle.copyWith(fontSize: 14),
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin - 80,
              child: customSubtitle != null
                  ? customSubtitle
                  : Text(
                      subtitle,
                      style: blackFontStyle3,
                      textAlign: TextAlign.right,
                    ))
        ]);
  }
}
