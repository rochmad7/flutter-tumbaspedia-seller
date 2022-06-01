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
      priceController.text = widget.product.price.toString();
      selectedCategory = widget.product.category;
    }
    super.initState();
  }

  void fetchData() async {
    try {
      final response = await http.get(baseURLAPI + '/categories',
          headers: {"Accept": "application/json", "Token": tokenAPI});
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
                    PickedFile pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      pictureFile = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  pictureFile: pictureFile,
                  imageURL: widget.product.images),
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
                  Product sproduct = new Product(
                      id: widget.product.id,
                      name: nameController.text ?? widget.product.name,
                      description: descriptionController.text ??
                          widget.product.description,
                      stock: stockController.text.toInt()  ?? widget.product.stock,
                      price: priceController.text.toInt() ?? widget.product.price,
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
