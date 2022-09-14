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
      final response = await http.get(baseURLAPI + '/categories',
          headers: {"Accept": "application/json", "Token": tokenAPI});
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
        subtitle: "Pastikan data yang diisi valid",
        child: Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
          child: Column(
            children: [
              ImagePickerDefault(
                  press: () async {
                    PickedFile pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      pictureFile = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  pictureFile: pictureFile),
              SizedBox(
                height: 15,
              ),
              LabelFormField(
                  label: "Nama Produk *", example: "Contoh: Toko Makmur"),
              TextFieldDefault(
                  icon: MdiIcons.starPlus,
                  controller: nameController,
                  hintText: "Nama Produk"),
              TextDanger(error: error, param: "name"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(label: "Kategori Produk *"),
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
              LabelFormField(label: "Harga Produk *", example: "Contoh: 20000"),
              TextFieldDefault(
                  icon: Icons.monetization_on,
                  controller: priceController,
                  hintText: "Harga Produk"),
              TextDanger(error: error, param: "price"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(label: "Stok Produk *", example: "Contoh: 5"),
              TextFieldDefault(
                  icon: MdiIcons.safe,
                  controller: stockController,
                  hintText: "Stok Produk"),
              TextDanger(error: error, param: "stock"),
              SizedBox(
                height: 15,
              ),
              LabelFormField(
                label: "Deskripsi Produk *",
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
                "* Wajib diisi",
                style: orangeFontStyle2.copyWith(fontSize: 12),
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
                      priceController.text.isEmpty) {
                    snackBar('Gagal menambahkan produk', 'Periksa kembali data',
                        'error');
                  }

                  Product product = Product(
                      name: nameController.text ?? nameController.text,
                      description: descriptionController.text ??
                          descriptionController.text,
                      stock: stockController.text.toInt() ??
                          stockController.text.toInt(),
                      price: priceController.text.toInt() ??
                          priceController.text.toInt(),
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
