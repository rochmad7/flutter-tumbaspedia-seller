part of 'pages.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  File pictureFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isLoading = false;
  String message;
  Map<String, dynamic> error;
  List<Category> categories;
  Category selectedCategory;

  @override
  void initState() {
    if (widget.product != null) {
      fetchData();
      nameController.text = widget.product.name;
      descriptionController.text = widget.product.description;
      stockController.text = widget.product.stock.toString();
      priceController.text = convertThousandFormatter(widget.product.price.toString());
      selectedCategory = widget.product.category;
    }
    super.initState();
  }

  void fetchData() async {
    try {
      final response = await http.get(baseURLAPI + '/categories?role=seller',
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        setState(() {
          var data = jsonDecode(response.body);

          categories = (data['data'] as Iterable)
              .map((e) => Category.fromJson(e))
              .toList();
        });
      }
    } on SocketException {
      setState(() {
        message = socketException;
      });
    } on HttpException {
      setState(() {
        message = httpException;
      });
    } on FormatException {
      setState(() {
        message = formatException;
      });
    } catch (e) {
      setState(() {
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
        title: 'Edit Produk',
        subtitle: "Pastikan data yang diisi valid",
        onBackButtonPressed: () async {
          await context
              .read<ProductCubit>()
              .getMyProducts(null, null, null, null);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
          child: Column(
            children: [
              ImagePickerDefault(
                  press: () async {
                    final PermissionStatus status =
                        await Permission.storage.request();

                    if (status.isGranted) {
                      PickedFile pickedFile = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        pictureFile = File(pickedFile.path);
                        setState(() {});
                      }
                    } else if (status.isDenied ||
                        status.isRestricted ||
                        status.isPermanentlyDenied) {
                      final PermissionStatus newStatus =
                          await Permission.storage.request();
                      if (newStatus.isGranted) {
                        PickedFile pickedFile = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          pictureFile = File(pickedFile.path);
                          setState(() {});
                        }
                      }

                      Get.snackbar(
                        "Izin Dibutuhkan",
                        "Izin penyimpanan dibutuhkan untuk mengupload gambar, silakan coba lagi.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        icon: Icon(MdiIcons.closeCircleOutline,
                            color: Colors.white),
                      );
                    }
                  },
                  pictureFile: pictureFile,
                  imageURL: widget.product.images),
              SizedBox(
                height: 15,
              ),
              LabelFormField(
                  label: "Nama Produk", example: "Contoh: Roti Bakar", isMandatory: true),
              TextFieldDefault(
                  icon: MdiIcons.tagHeart,
                  controller: nameController,
                  hintText: "Nama Produk"),
              TextDanger(error: error, param: "name"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(label: "Kategori Produk", isMandatory: true),
              DropdownDefault(
                selectedCategory: selectedCategory,
                categoryItems: categories != null
                    ? categories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                              style: blackFontStyle3,
                            ),
                          ),
                        )
                        .toList()
                    : null,
                onChanged: (item) {
                  setState(() {
                    selectedCategory = item;
                  });
                },
              ),
              TextDanger(error: error, param: "category_id"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(label: "Harga Produk", example: "Contoh: 20000", isMandatory: true),
              TextFieldDefault(
                  icon: Icons.monetization_on,
                  controller: priceController,
                  isPriceType: true,
                  isNumberType: true,
                  hintText: "Harga Produk"),
              TextDanger(error: error, param: "price"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(label: "Stok Produk", example: "Contoh: 5", isMandatory: true),
              TextFieldDefault(
                  icon: MdiIcons.safe,
                  controller: stockController,
                  isNumberType: true,
                  hintText: "Stok Produk"),
              TextDanger(error: error, param: "stock"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(
                label: "Deskripsi Produk", isMandatory: true,
              ),
              TextFieldDefault(
                  isPrefixIcon: false,
                  isMaxLines: true,
                  maxLines: 7,
                  controller: descriptionController,
                  hintText: "Deskripsi Produk"),
              TextDanger(error: error, param: "description"),
              // ErrorValidation(error: error),
              SizedBox(
                height: 5,
              ),
              Text(
                "Tanda (*) wajib diisi",
                style: greyFontStyle.copyWith(fontSize: 12, color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonDefault(
                isLoading: isLoading,
                title: "Simpan Data",
                press: () async {
                  if (nameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      stockController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      selectedCategory == null) {
                    snackBar(
                        'Gagal edit produk', 'Harap isi semua data', 'error');
                    return;
                  }

                  String newPrice = reverseThousandsSeparator(priceController.text);
                  if (stockController.text.isNumericOnly == false ||
                      int.parse(stockController.text) < 0 ||
                      int.parse(newPrice) < 0) {
                    snackBar('Gagal edit produk', 'Harap isi data dengan benar',
                        'error');
                    return;
                  }

                  Product sproduct = new Product(
                      id: widget.product.id,
                      name: nameController.text ?? widget.product.name,
                      description: descriptionController.text ??
                          widget.product.description,
                      stock:
                          stockController.text.toInt() ?? widget.product.stock,
                      price:
                          newPrice.toInt() ?? widget.product.price,
                      category: selectedCategory ?? widget.product.category);

                  setState(() {
                    isLoading = true;
                  });

                  await context
                      .read<ProductCubit>()
                      .update(sproduct, pictureFile: pictureFile);

                  ProductState state = context.read<ProductCubit>().state;

                  if (state is ProductEdited) {
                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);

                    setState(() {
                      isLoading = false;
                    });
                    Get.to(() => MainPage(
                          initialPage: 1,
                        ));
                    snackBar("Berhasil", "Produk berhasil diupdate", 'success');
                  } else {
                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);
                    snackBar("Produk gagal diupdate",
                        (state as ProductEditedFailed).message, 'error');
                    setState(() {
                      error = (state as ProductEditedFailed).error != null
                          ? (state as ProductEditedFailed).error
                          : null;
                      pictureFile = null;
                      isLoading = false;
                    });
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
