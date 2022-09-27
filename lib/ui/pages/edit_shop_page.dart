part of 'pages.dart';

class EditShopPage extends StatefulWidget {
  final Shop shop;
  final User user;

  EditShopPage({this.shop, this.user});

  @override
  _EditShopPageState createState() => _EditShopPageState();
}

class _EditShopPageState extends State<EditShopPage> {
  File pictureFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopOpenController = TextEditingController();
  TextEditingController shopClosedController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> error;

  // List<Category> categories;
  // Category selectedCategory;

  @override
  void initState() {
    if (widget.shop != null && widget.user != null) {
      // fetchData();
      nameController.text = widget.user.name;
      phoneController.text = widget.user.phoneNumber;
      shopNameController.text = widget.shop.name;
      shopDescController.text = widget.shop.description;
      shopAddressController.text = widget.shop.address;
      shopOpenController.text = widget.shop.openingHours;
      shopClosedController.text = widget.shop.closedHours;
      // selectedCategory = widget.shop.category;
    }
    super.initState();
  }

  // void fetchData() async {
  //   final response = await http.get('http://doltinuku.id/api/category');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       var data = jsonDecode(response.body);

  //       categories = (data['data']['data'] as Iterable)
  //           .map((e) => Category.fromJson(e))
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Data Toko',
      subtitle: "Pastikan data yang diisi valid",
      onBackButtonPressed: () async {
        // await context.read<UserCubit>().getMyProfile(widget.shop);
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
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
                imageURL: widget.shop.images),
            SizedBox(height: 15),
            LabelFormField(label: "Nama Toko", example: "Contoh: Toko Makmur"),
            TextFieldDefault(
                icon: Icons.shop,
                controller: shopNameController,
                hintText: "Nama Toko"),
            TextDanger(error: error, param: "name"),
            SizedBox(height: 15),
            // LabelFormField(label: "Kategori Toko *"),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     border: Border.all(
            //       color: Colors.black,
            //       width: 0,
            //     ),
            //   ),
            //   child: DropdownButton(
            //     value: selectedCategory,
            //     isExpanded: true,
            //     underline: SizedBox(),
            //     items: categories != null
            //         ? categories
            //             .map(
            //               (e) => DropdownMenuItem(
            //                 value: e,
            //                 child: Text(
            //                   e.name,
            //                   style: blackFontStyle3,
            //                 ),
            //               ),
            //             )
            //             .toList()
            //         : null,
            //     onChanged: (item) {
            //       setState(() {
            //         selectedCategory = item;
            //       });
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // LabelFormField(label: "Nama Pemilik"),
            // TextFieldDefault(
            //     icon: Icons.person,
            //     controller: nameController,
            //     hintText: "Nama Pemilik"),
            // TextDanger(error: error, param: "name"),
            SizedBox(height: 15),
            LabelFormField(
                label: "No HP Pemilik", example: "Contoh: 0878785677"),
            TextFieldDefault(
                icon: MdiIcons.phone,
                controller: phoneController,
                hintText: "No HP Pemilik"),
            TextDanger(error: error, param: "phone_number"),
            SizedBox(height: 15),
            LabelFormField(label: "Jam Buka Toko"),
            TextFieldDefault(
                enableInteractiveSelection: false,
                icon: MdiIcons.clock,
                controller: shopOpenController,
                press: () async {
                  TimeOfDay timeOpen = timeConvert(shopOpenController.text);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  TimeOfDay pickedOpen = await showTimePicker(
                      context: context,
                      initialTime: timeOpen,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      });
                  if (pickedOpen != null && pickedOpen != timeOpen) {
                    // shopOpenController.text = pickedOpen.format(context);
                    shopOpenController.text = pickedOpen.hour.toString().padLeft(2, '0') +
                        ':' +
                        pickedOpen.minute.toString().padLeft(2, '0') +
                        ':00';
                    setState(() {
                      timeOpen = pickedOpen;
                    });
                  }
                },
                hintText: "Klik untuk mengatur"),
            TextDanger(error: error, param: "opened_at"),
            SizedBox(height: 15),
            LabelFormField(label: "Jam Tutup Toko"),
            TextFieldDefault(
                enableInteractiveSelection: false,
                icon: MdiIcons.clock,
                controller: shopClosedController,
                press: () async {
                  TimeOfDay timeClosed = timeConvert(shopClosedController.text);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  TimeOfDay pickedClosed = await showTimePicker(
                      context: context,
                      initialTime: timeClosed,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      });
                  if (pickedClosed != null && pickedClosed != timeClosed) {
                    // shopClosedController.text = pickedClosed.format(context);
                    shopClosedController.text = pickedClosed.hour.toString().padLeft(2, '0') +
                        ':' +
                        pickedClosed.minute.toString().padLeft(2, '0') +
                        ':00';
                    setState(() {
                      timeClosed = pickedClosed;
                    });
                  }
                },
                hintText: "Klik untuk mengatur"),
            TextDanger(error: error, param: "closed_at"),
            SizedBox(height: 15),
            LabelFormField(label: "Alamat Toko"),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 3,
                controller: shopAddressController,
                hintText: "Alamat Toko"),
            TextDanger(error: error, param: "address"),
            SizedBox(height: 15),
            LabelFormField(label: "Deskripsi Toko"),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 5,
                controller: shopDescController,
                hintText: "Deskripsi Toko"),
            TextDanger(error: error, param: "description"),
            SizedBox(height: 15),
            ButtonDefault(
              isLoading: isLoading,
              title: "Simpan Data",
              press: () async {
                if (shopNameController.text.isEmpty ||
                    shopOpenController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    shopClosedController.text.isEmpty ||
                    shopAddressController.text.isEmpty ||
                    shopDescController.text.isEmpty) {
                  snackBar(
                      'Edit toko gagal', 'Pastikan semua data terisi', 'error');
                  return;
                } else if (!phoneController.text.isPhoneNumber) {
                  snackBar('Edit toko gagal', 'No HP tidak valid', 'error');
                  return;
                } else if (shopOpenController.text == shopClosedController.text) {
                  snackBar('Edit toko gagal', 'Jam buka dan tutup tidak boleh sama', 'error');
                  return;
                }

                var format = DateFormat("HH:mm");

                if (format
                    .parse(shopOpenController.text)
                    .isAfter(format.parse(shopClosedController.text))) {
                  snackBar(
                      'Edit toko gagal',
                      'Jam buka tidak boleh lebih besar dari jam tutup',
                      'error');
                  return;
                }

                Shop shop = Shop(
                    id: (context.read<UserCubit>().state as UserLoadedWithShop)
                        .shop
                        .id,
                    name: shopNameController.text,
                    address: shopAddressController.text,
                    description: shopDescController.text,
                    openingHours: shopOpenController.text,
                    closedHours: shopClosedController.text);

                // User user = User(
                //   name: nameController.text,
                //   phoneNumber: phoneController.text,
                // );

                setState(() {
                  isLoading = true;
                });

                await context
                    .read<UserCubit>()
                    .update(shop, pictureFile: pictureFile);

                UserState state = context.read<UserCubit>().state;

                if (state is UserEdited) {
                  context.read<UserCubit>().getMyProfile(shop);
                  Get.to(() => MainPage(
                        initialPage: 0,
                      ));
                  snackBar(
                      "Berhasil", "Data toko berhasil diupdate", 'success');

                  setState(() {
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  context.read<UserCubit>().getMyProfile(shop);
                  snackBar("Data toko gagal diupdate",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    pictureFile = null;
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
