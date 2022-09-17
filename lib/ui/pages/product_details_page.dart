part of 'pages.dart';

class ProductDetailsPage extends StatefulWidget {
  final Function onBackButtonPressed;
  final Transaction transaction;

  ProductDetailsPage({this.onBackButtonPressed, this.transaction});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  int selectedIndex = 0;
  String image;
  bool isLoadingRating = false;
  bool isLoadingPhoto = false;
  var listPhotos = <Photo>[];
  List<Photo> photos;
  var rating = Rating();
  List<Rating> listRatings;

  @override
  void initState() {
    image = widget.transaction.product.images;
    super.initState();
    fetchPhotoByProduct();
    // if (widget.transaction.product.totalReview > 0) {
    //   fetchRatingsByProduct();
    // }
  }

  void fetchPhotoByProduct() async {
    isLoadingPhoto = true;
    final response = await http.get(
        baseURLAPI +
            '/product-pictures?product_id=' +
            widget.transaction.product.id.toString(),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['data'] != []) {
      if (mounted) {
        setState(() {
          photos =
              (data['data'] as Iterable).map((e) => Photo.fromJson(e)).toList();
          listPhotos.clear();
          listPhotos.addAll(photos);
          Photo initial =
          Photo(id: 0, images: widget.transaction.product.images);
          if (!listPhotos.contains(initial)) {
            listPhotos.insert(0, initial);
          }
          isLoadingPhoto = false;
        });
      }
    }
  }

  // void fetchRatingsByProduct() async {
  //   isLoadingRating = true;
  //   final response = await http.get(
  //       baseURLAPI +
  //           'product/rating?product_id=' +
  //           widget.transaction.product.id.toString() +
  //           '&limit=1',
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //         "Token": tokenAPI
  //       });
  //   if (response.statusCode == 200) {
  //     if (mounted) {
  //       setState(() {
  //         var data = jsonDecode(response.body);
  //         listRatings = (data['data']['data'] as Iterable)
  //             .map((e) => Rating.fromJson(e))
  //             .toList();
  //         rating = listRatings[0];
  //         isLoadingRating = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: mainColor,
          ),
          SafeArea(
              child: Container(
                color: Colors.white,
              )),
          SafeArea(
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) =>
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
              imageUrl: image,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SafeArea(
              child: ListView(
                children: [
                  Column(
                    children: [
                      //// Back Button
                      Container(
                        height: 100,
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () async {
                              // await context
                              //     .read<ProductCubit>()
                              //     .getMyProducts(null, null, null, null);
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black12),
                              child:
                              Image.asset('assets/icons/back_arrow_white.png'),
                            ),
                          ),
                        ),
                      ),
                      //// Body
                      Container(
                        margin: EdgeInsets.only(top: 180),
                        padding: EdgeInsets.symmetric(
                            vertical: 26, horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          140, // 32 + 102
                                      child: Text(
                                        widget.transaction.product.name,
                                        style: blackFontStyle2,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        // iconText(
                                        //     MdiIcons.star,
                                        //     widget.transaction.product.rating
                                        //         .toStringAsFixed(1) +
                                        //         (widget.transaction.product
                                        //             .totalReview ==
                                        //             0
                                        //             ? ""
                                        //             : " (" +
                                        //             formatNumber(widget
                                        //                 .transaction
                                        //                 .product
                                        //                 .totalReview) +
                                        //             " review)"),
                                        //     null),
                                        const SizedBox(width: 8),
                                        iconText(
                                            MdiIcons.cart,
                                            "Terjual " +
                                                formatNumber(widget
                                                    .transaction.product.sold),
                                            15)
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      getFormatRupiah(
                                          widget.transaction.product.price,
                                          true),
                                      style: blackFontStyle2.copyWith(
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "Stok " +
                                          (widget.transaction.product.stock == 0
                                              ? "habis"
                                              : ": " +
                                              widget.transaction.product.stock
                                                  .toString()),
                                      style: widget.transaction.product.stock ==
                                          0
                                          ? redFontStyle.copyWith(fontSize: 12)
                                          : blackFontStyle3.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (listPhotos.length == 1)
                                    ? _productImages(
                                    selectedIndex, selectedIndex,
                                    widget.transaction.product.images)
                                    : Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width - 160,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: (isLoadingPhoto)
                                        ? ShimmerRow(
                                        height: 30,
                                        itemCount: 9,
                                        isNoMargin: true,
                                        isSymmetric: false)
                                        : ProductImages(
                                      photos: listPhotos,
                                      selectedIndex: selectedIndex,
                                      onTap: (index) {
                                        setState(() {
                                          selectedIndex = index;
                                          image =
                                              listPhotos[index].images;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Chip(
                                    avatar: (listPhotos.length < 2 &&
                                        (widget.transaction.product.category
                                            .name)
                                            .length <
                                            10)
                                        ? CircleAvatar(
                                      backgroundColor: Colors.grey.shade800,
                                      child: Icon(MdiIcons.tag),
                                    )
                                        : null,
                                    label: Text(
                                        widget.transaction.product.category
                                            .name,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                        blackFontStyle3.copyWith(fontSize: 11)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            ExpandableText(
                                header: Text('Deskripsi:',
                                    style: titleListStyle.copyWith(
                                        fontSize: 14)),
                                text: widget.transaction.product.description,
                                maxLines: 4),
                            SizedBox(height: 25),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SectionTitle(
                            //       all: widget.transaction.product.totalReview >
                            //           1
                            //           ? true
                            //           : false,
                            //       press: () =>
                            //           Get.to(() =>
                            //               AllReviewsPage(
                            //                   productId: widget.transaction
                            //                       .product.id)),
                            //       isColor: true,
                            //       sizeTitle: 15,
                            //       title: "Penilaian Produk",
                            //       defaultMargin: 0,
                            //     ),
                            //     SizedBox(height: 10),
                            //     widget.transaction.product.totalReview < 1
                            //         ? CustomAlert(
                            //         icon: MdiIcons.alert,
                            //         type: 'warning',
                            //         isDistance: false,
                            //         title: 'Belum ada penilaian produk')
                            //         : isLoadingRating
                            //         ? ShimmerRow(
                            //         height: 80,
                            //         itemCount: 2,
                            //         isNoMargin: true,
                            //         isSymmetric: false)
                            //         : CommentRating(rating: rating),
                            //     SizedBox(height: 30),
                            //   ],
                            // ),
                            Row(
                              children: [
                                ButtonFlexible(
                                    title: "Tambah Foto",
                                    press: () =>
                                        Get.to(() =>
                                            UploadPage(
                                                product: widget.transaction
                                                    .product)),
                                    icon: Icons.add_a_photo,
                                    color: Colors.blue),
                                SizedBox(width: 5),
                                ButtonFlexible(
                                  title: "Hapus Foto",
                                  press: () {
                                    SweetAlert.show(context,
                                        subtitle: "Yakin foto produk akan dihapus?",
                                        style: SweetAlertStyle.confirm,
                                        showCancelButton: true,
                                        onPress: delete);
                                  },
                                  icon: MdiIcons.fileRemove,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                ButtonFlexible(
                                  title: "Edit Produk",
                                  press: () =>
                                      Get.to(() =>
                                          EditProductPage(
                                              product: widget.transaction
                                                  .product)),
                                  icon: Icons.edit,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(width: 5),
                                ButtonFlexible(
                                  title: "Hapus Produk",
                                  press: () {
                                    showAlertDialog(context, () async {
                                      await context.read<ProductCubit>()
                                          .destroy(
                                        widget.transaction.product,
                                      );
                                      ProductState state =
                                          context
                                              .read<ProductCubit>()
                                              .state;
                                      if (state is ProductDeleted) {
                                        // context
                                        //     .read<ProductCubit>()
                                        //     .getMyProducts(null, null, null, null);

                                        Get.to(() => MainPage(initialPage: 1));
                                        snackBar("Berhasil",
                                            "Produk berhasil dihapus",
                                            'success');
                                      } else {
                                        // context
                                        //     .read<ProductCubit>()
                                        //     .getMyProducts(null, null, null, null);
                                        snackBar(
                                            "Gagal menghapus!",
                                            (state as ProductDeletedFailed)
                                                .message,
                                            'error');
                                      }
                                    }, "Hapus",
                                        "Yakin produk ini akan dihapus?");
                                  },
                                  icon: Icons.delete,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  Row iconText(IconData icon, String title, double iconSize) {
    return Row(children: [
      Icon(
        icon,
        size: iconSize ??= defaultIconSize,
        color: secondaryColor,
      ),
      const SizedBox(width: 4),
      Text(title, style: greyFontStyle12)
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool delete(bool isConfirm) {
    if (isConfirm) {
      SweetAlert.show(context,
          subtitle: "Menghapus...", style: SweetAlertStyle.loading);
      new Future.delayed(new Duration(seconds: 0), () async {
        await context
            .read<PhotoCubit>()
            .destroyMultiple(widget.transaction.product, true);
        PhotoState state = context
            .read<PhotoCubit>()
            .state;
        if (state is PhotoDeleted) {
          SweetAlert.show(context,
              subtitle: "Foto produk berhasil dihapus!",
              style: SweetAlertStyle.success);
          // context.read<ProductCubit>().getMyProducts(null, null, null, null);
          new Future.delayed(new Duration(seconds: 1), () {
            Get.off(MainPage(initialPage: 1));
          });
          return false;
        } else {
          SweetAlert.show(context,
              subtitle: "Foto produk gagal dihapus!",
              style: SweetAlertStyle.error);
          return false;
        }
      });
    } else {
      SweetAlert.show(context,
          subtitle: "Dibatalkan!", style: SweetAlertStyle.error);
    }
    return false;
  }
}

showAlertDialog(BuildContext context, Function press, String continueTextButton,
    String title) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(primary: greyColor),
    child: Text("Batal", style: whiteFontStyle2),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: "4A934A".toColor(),
      ),
      child: Text(continueTextButton, style: whiteFontStyle2),
      onPressed: press);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Perhatian!",
        style: blackFontStyle1.copyWith(fontWeight: FontWeight.bold)),
    content: Text(title, style: blackFontStyle2),
    actions: [continueButton, cancelButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ProductImages extends StatelessWidget {
  final List<Photo> photos;
  final int selectedIndex;
  final Function(int) onTap;

  ProductImages({this.selectedIndex, this.onTap, this.photos});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(photos.length, (index) {
        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap(index);
            }
          },
          child: Row(
            children: [
              SizedBox(width: index == 0 ? 0 : 5),
              _productImages(selectedIndex, index, photos[index].images),
            ],
          ),
        );
      }),
    );
  }
}

Widget _productImages(int selectedIndex, int index, String imageUrl) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) =>
        Container(
          height: 35,
          width: 45,
          decoration: BoxDecoration(
            border: (index == selectedIndex)
                ? Border.all(color: Colors.orange, width: 3)
                : null,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) =>
        CardShimmer(isSymmetric: false, height: 35, isCircular: true),
    errorWidget: (context, url, error) => Icon(Icons.error),
    repeat: ImageRepeat.repeat,
  );
}
