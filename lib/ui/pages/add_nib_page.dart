part of 'pages.dart';

class AddNibPage extends StatefulWidget {
  final Shop shop;
  final User user;
  AddNibPage({this.shop, this.user});

  @override
  _AddNibPageState createState() => _AddNibPageState();
}

class _AddNibPageState extends State<AddNibPage> {
  File pictureFile;

  bool isLoading = false;
  Map<String, dynamic> error;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Upload NIB',
      subtitle: "Pastikan data yang diisi valid",
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
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
            // ErrorValidation(error: error),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
              isLoading: isLoading,
              title: "Simpan Data",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                await context
                    .read<UserCubit>()
                    .addNib(widget.user, widget.shop, pictureFile: pictureFile);

                UserState state = context.read<UserCubit>().state;

                if (state is UserLoadedWithShop) {
                  context
                      .read<ProductCubit>()
                      .getMyProducts(null, null, null, null);
                  setState(() {
                    isLoading = false;
                  });
                  Get.to(()=>WaitingShopPage(
                      shopInitial: widget.shop, userInitial: widget.user));
                  snackBar(
                      "Berhasil", "Data NIB berhasil ditambahkan", 'success');
                } else {
                  snackBar("Data NIB gagal ditambahkan",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    pictureFile = null;
                    isLoading = false;
                  });
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
  }
}
