part of 'pages.dart';

class AddShopPage extends StatefulWidget {
  final User user;
  final String password;

  AddShopPage(this.user, this.password);

  @override
  _AddShopPageState createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  File pictureFile;
  File nibFile;

  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> error;
  List<Category> categories;
  Category selectedCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Data Toko',
      subtitle: "Pastikan data yang diisi valid",
      onBackButtonPressed: () {
        Get.off(SignUpPage(user: widget.user, password: widget.password));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            LabelFormField(
                label: "Logo/Gambar Toko", example: ".jpg, .png, max: 2mb"),
            ImagePickerDefault(
                press: () async {
                  PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    pictureFile = File(pickedFile.path);
                    setState(() {});
                  }
                },
                pictureFile: pictureFile,
                isMargin: true,
                isPadding: true,
                height: 150,
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
            TextDanger(error: error, param: "shopname"),
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
            TextDanger(error: error, param: "shopaddress"),
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
            TextDanger(error: error, param: "shopdescription"),
            SizedBox(
              height: 15,
            ),
            LabelFormField(
                label: "File NIB Toko *", example: ".jpg, .png, max: 2mb"),
            Text(
              "*NIB adalah Nomor Induk Berusaha yang merupakan syarat mendaftar sebagai penjual di aplikasi Shop Doltinuku",
              style: blackFontStyle3.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: 5,
            ),
            ImagePickerDefault(
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
                height: 150,
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
                Shop shop = Shop(
                    name: shopNameController.text,
                    address: shopAddressController.text,
                    description: shopDescController.text);

                User user = widget.user;

                setState(() {
                  isLoading = true;
                });
                // await context.read<UserCubit>().signUp(
                //     user, widget.password, shop,
                //     pictureFile: pictureFile, nibFile: nibFile);
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
                } else {
                  snackBar("Pendaftaran Gagal",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    pictureFile = null;
                    nibFile = null;
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
      ),
    );
  }
}
