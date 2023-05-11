part of 'pages.dart';

class AddShopPage extends StatefulWidget {
  final User user;
  final String password;
  Shop shop;

  AddShopPage({this.user, this.password, this.shop});

  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  File pictureFile;
  File nibFile;

  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopNIBController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> error;
  List<Category> categories;
  Category selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.shop != null) {
      shopNameController.text = widget.shop.name;
      shopDescController.text = widget.shop.description;
      shopAddressController.text = widget.shop.address;
      shopNIBController.text = widget.shop.nibNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Data Toko',
      subtitle: "Pastikan data yang diisi valid",
      onBackButtonPressed: () {
        Get.off(SignUpPage(
            user: widget.user, password: widget.password, shop: widget.shop));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            LabelFormField(
                label: "Logo/Gambar Toko", example: ".jpg, .png, max: 2mb"),
            ImagePickerDefault(
              imageURL: imageUploadUrl,
                press: () async {
                  final PermissionStatus status =
                  await Permission.storage.request();

                  if (status.isGranted) {
                    PickedFile pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      pictureFile = File(pickedFile.path);
                      setState(() {});
                    }
                  } else if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
                    final PermissionStatus newStatus = await Permission.storage.request();
                    if (newStatus.isGranted) {
                      PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
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
                      icon:
                      Icon(MdiIcons.closeCircleOutline, color: Colors.white),
                    );
                  }
                },
                pictureFile: pictureFile,
                isMargin: true,
                isPadding: true,
                height: pictureFile == null ? 150 : 200,
                width: double.infinity,
                isCircle: false),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
                label: "Nama Toko *", example: "Contoh: Toko Makmur"),
            TextFieldDefault(
                icon: Icons.shop,
                controller: shopNameController,
                hintText: "Nama Toko"),
            TextDanger(error: error, param: "shop_name"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(label: "Alamat Toko *"),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 3,
                controller: shopAddressController,
                hintText: "Alamat Toko"),
            TextDanger(error: error, param: "shop_address"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
              label: "Deskripsi Toko *",
            ),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 6,
                controller: shopDescController,
                hintText: "Deskripsi Toko"),
            TextDanger(error: error, param: "shop_description"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
                label: "Nomor NIB Toko *", example: "Contoh: 123456"),
            TextFieldDefault(
                icon: Icons.confirmation_number,
                controller: shopNIBController,
                hintText: "Nomor NIB Toko"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
                label: "File NIB Toko *", example: ".jpg, .png, max: 2mb"),
            Text(
              "*NIB adalah Nomor Induk Berusaha yang merupakan syarat mendaftar sebagai penjual di aplikasi Tumbaspedia Seller",
              style: blackFontStyle3.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            ImagePickerDefault(
              imageURL: imageUploadUrl,
                press: () async {
                  PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    nibFile = File(pickedFile.path);
                    setState(() {});
                  }
                },
                pictureFile: nibFile,
                isMargin: true,
                isPadding: true,
                height: pictureFile == null ? 150 : 200,
                width: double.infinity,
                isCircle: false),
            SizedBox(
              height: 5,
            ),
            Text(
              "* Wajib diisi",
              style: orangeFontStyle2.copyWith(fontSize: 12),
            ),
            // ErrorValidation(error: error),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
              isLoading: isLoading,
              title: "Daftar Toko",
              press: () async {
                if (shopNameController.text.isEmpty ||
                    shopAddressController.text.isEmpty ||
                    shopDescController.text.isEmpty ||
                    shopNIBController.text.isEmpty) {
                  // setState(() {
                  //   error = {
                  //     "shop_name": "Nama Toko tidak boleh kosong",
                  //     "shop_address": "Alamat Toko tidak boleh kosong",
                  //     "shop_description": "Deskripsi Toko tidak boleh kosong"
                  //   };
                  // });
                  snackBar("Gagal Melanjutkan",
                      "Semua kolom bertanda bintang harus diisi", 'error');

                  return;
                }
                Shop shop = Shop(
                    name: shopNameController.text,
                    address: shopAddressController.text,
                    description: shopDescController.text,
                    nibNumber: shopNIBController.text);

                User user = widget.user;

                setState(() {
                  isLoading = true;
                });
                await context.read<UserCubit>().signUp(
                    user, widget.password, shop,
                    pictureFile: pictureFile, nibFile: nibFile);
                UserState state = context.read<UserCubit>().state;

                if (state is UserLoadedWithShop) {
                  // context
                  //     .read<ProductCubit>()
                  //     .getMyProducts(null, null, null, null);
                  User user =
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .user;
                  Shop shop =
                      (context.read<UserCubit>().state as UserLoadedWithShop)
                          .shop;
                  Get.offAll(() =>
                      WaitingShopPage(shopInitial: shop, userInitial: user));
                  snackBar("Berhasil", "Pendaftaran toko berhasil", 'success');
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  snackBar("Pendaftaran Gagal",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    // pictureFile = null;
                    // nibFile = null;
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
