part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ProductCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.08,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: product.images,
                      fit: BoxFit.cover,
                      // placeholder: (context, url) =>
                      //     CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: mainColor,
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  alignment: Alignment.center,
                  child: Text("Terjual " + formatNumber(product.sold),
                      style: whiteFontStyle.copyWith(fontSize: 11)),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "${product.name}",
            style: GoogleFonts.roboto().copyWith(color: Colors.black),
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getFormatRupiah(product.price, false),
                style: GoogleFonts.roboto().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
