part of 'pages.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File pictureFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isLoading = false;
  String message;
  Map<String, dynamic> error;
  List<Category> categories;
  Category selectedCategory;

  @override
  void initState() {
    fetchData();
    super.initState();
    nameController.text = '';
    descriptionController.text = '';
    stockController.text = '';
    priceController.text = '';
  }

  void fetchData() async {
    try {
      final response = await http.get(baseURLAPI + '/categories?role=seller',
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) if (mounted)
        setState(() {
          var data = jsonDecode(response.body);

          categories = (data['data'] as Iterable)
              .map((e) => Category.fromJson(e))
              .toList();
          selectedCategory = categories[0];
        });
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
    bool isLogin = (context.watch<UserCubit>().state is UserLoadedWithShop);
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
        buttonTap1: () {
          Get.to(() => SignInPage());
        },
        buttonTitle1: 'Login',
      );
    else if (isLogin)
      return GeneralPage(
        title: 'Tambah Produk',
        subtitle: "Tambahkan produk baru untuk dijual",
        child: Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
          child: Column(
            children: [
              ImagePickerDefault(
                  imageURL: imageUploadUrl,
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
                  pictureFile: pictureFile),
              SizedBox(height: 15),
              LabelFormField(
                  label: "Nama Produk",
                  example: "Contoh: Roti Bakar",
                  isMandatory: true),
              TextFieldDefault(
                  icon: MdiIcons.tagHeart,
                  controller: nameController,
                  hintText: "Nama Produk"),
              TextDanger(error: error, param: "name"),
              SizedBox(height: 15),
              LabelFormField(label: "Kategori Produk", isMandatory: true),
              DropdownDefault(
                selectedCategory: selectedCategory,
                categoryItems: categories != null
                    ? categories
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name, style: blackFontStyle3),
                            ))
                        .toList()
                    : null,
                onChanged: (item) {
                  setState(() {
                    selectedCategory = item;
                  });
                },
              ),
              TextDanger(error: error, param: "category_id"),
              SizedBox(height: 15),
              LabelFormField(
                  label: "Harga Produk",
                  example: "Contoh: 20000",
                  isMandatory: true),
              TextFieldDefault(
                icon: Icons.attach_money,
                controller: priceController,
                hintText: "Harga Produk",
                isPriceType: true,
                isNumberType: true,
              ),
              TextDanger(error: error, param: "price"),
              SizedBox(height: 15),
              LabelFormField(
                  label: "Stok Produk",
                  example: "Contoh: 5",
                  isMandatory: true),
              TextFieldDefault(
                  icon: MdiIcons.tagPlus,
                  controller: stockController,
                  isNumberType: true,
                  hintText: "Stok Produk"),
              TextDanger(error: error, param: "stock"),
              SizedBox(height: 15),
              LabelFormField(label: "Deskripsi Produk", isMandatory: true),
              TextFieldDefault(
                  isPrefixIcon: false,
                  isMaxLines: true,
                  maxLines: 7,
                  controller: descriptionController,
                  hintText: "Deskripsi Produk"),
              TextDanger(error: error, param: "description"),
              SizedBox(height: 5),
              Text("Tanda (*) wajib diisi", style: redFontStyle),
              SizedBox(height: 15),
              ButtonDefault(
                isLoading: isLoading,
                title: "Simpan Data",
                press: () async {
                  if (nameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      stockController.text.isEmpty ||
                      priceController.text.isEmpty) {
                    snackBar('Gagal menambahkan produk', 'Periksa kembali data',
                        'error');
                    return;
                  }

                  String newPrice =
                      reverseThousandsSeparator(priceController.text);
                  if (stockController.text.isNumericOnly == false ||
                      int.parse(stockController.text) < 0 ||
                      int.parse(newPrice) < 0) {
                    snackBar('Gagal menambahkan produk',
                        'Data yang diisi tidak valid', 'error');
                    return;
                  }

                  if (pictureFile == null) {
                    snackBar('Gagal menambahkan produk',
                        'Gambar produk tidak boleh kosong', 'error');
                    return;
                  }

                  Product product = Product(
                      name: nameController.text ?? nameController.text,
                      description: descriptionController.text ??
                          descriptionController.text,
                      stock: stockController.text.toInt() ??
                          stockController.text.toInt(),
                      price: newPrice.toInt() ?? priceController.text.toInt(),
                      category: selectedCategory);

                  setState(() {
                    isLoading = true;
                  });

                  await context.read<ProductCubit>().store(
                      product,
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .shop,
                      pictureFile: pictureFile);
                  ProductState state = context.read<ProductCubit>().state;

                  if (state is ProductAdded) {
                    nameController.text = '';
                    descriptionController.text = '';
                    stockController.text = '';
                    priceController.text = '';
                    pictureFile = null;
                    FocusManager.instance.primaryFocus?.unfocus();

                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);
                    setState(() {
                      isLoading = false;
                    });
                    Get.to(() => MainPage(
                          initialPage: 1,
                        ));
                    snackBar(
                        "Berhasil", "Produk berhasil ditambahkan", 'success');
                  } else {
                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);
                    snackBar("Produk gagal ditambahkan",
                        (state as ProductAddedFailed).message, 'error');

                    setState(() {
                      error = (state as ProductAddedFailed).error != null
                          ? (state as ProductAddedFailed).error
                          : null;
                      pictureFile = null;
                      isLoading = false;
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      );
    else
      return loadingIndicator;
  }
}
