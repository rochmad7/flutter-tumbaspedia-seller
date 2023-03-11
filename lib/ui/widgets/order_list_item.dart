part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final Transaction transaction;
  final double itemWidth;
  final Function press;
  final bool isDate;

  OrderListItem(
      {@required this.transaction,
        this.isDate = true,
        @required this.itemWidth,
        this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWidth,
      child: Column(
        children: [
          GestureDetector(
            onTap: press,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 75,
                  margin: EdgeInsets.only(right: 14),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: transaction.product.images,
                    placeholder: (context, url) => CardShimmer(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                SizedBox(
                  width: itemWidth - 184, // (60 + 12 + 110)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.product.name,
                        style: blackFontStyle2.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${transaction.quantity} produk",
                        style: greyFontStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Total: " + getFormatRupiah(transaction.total, true),
                        style: blackFontStyle2.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                isDate
                    ? SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        convertDate(transaction.dateTime, false),
                        style: blackFontStyle2.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Text(
                        convertTime(transaction.dateTime),
                        style: blackFontStyle2.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Container(
                        width: 110,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: mainColor),
                        ),
                        child: Center(
                          child: Text(
                            transaction.status ==
                                TransactionStatus.canceled
                                ? "Dibatalkan"
                                : transaction.status ==
                                TransactionStatus.pending
                                ? "Pesanan Baru"
                                : transaction.status ==
                                TransactionStatus.on_delivery
                                ? "Diantar"
                                : "Selesai",
                            style: blackFontStyle2.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(height: 12),
          Divider(
            thickness: 1,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}