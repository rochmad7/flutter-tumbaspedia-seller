part of 'pages.dart';

class EditTransactionPage extends StatefulWidget {
  final Transaction transaction;

  EditTransactionPage({this.transaction});

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  File pictureFile;

  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();

  bool isLoading = false;
  List<String> status;
  String selectedStatus;

  @override
  void initState() {
    if (widget.transaction != null) {
      status = ['Pesanan Baru', 'Dibatalkan', 'Diantar'];
      selectedStatus = (widget.transaction.status == TransactionStatus.pending)
          ? status[0]
          : (widget.transaction.status == TransactionStatus.cancelled)
              ? status[1]
              : status[2];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Data Pesanan',
      subtitle: "Pastikan data yang diisi valid",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
                'Anda dapat mengubah status pesanan ini dengan kesepakatan pembeli. Status yang ada adalah:\n1. Pesanan baru (ketika pembeli pertama kali memesan produk Anda)\n2. Pesanan dibatalkan (apabila Anda/pembeli membatalkan pesanan)\n3. Pesanan diantar (status final untuk penjual, tidak dapat diubah lagi oleh penjual)\n4. Pesanan selesai (pembeli sudah mengkonfirmasi pesanan diterima dengan mengklik tombol "Terima pesanan")',
                style: blackFontStyle),
            SizedBox(height: 15),
            LabelFormField(label: "Ubah status pesanan ini"),
            DropdownDefault(
              isCategory: false,
              selectedItem: selectedStatus,
              items: status
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: blackFontStyle3,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  selectedStatus = item;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
                isLoading: isLoading,
                title: "Simpan Data",
                press: () {
                  showAlertDialog(context, () async {
                    setState(() {
                      isLoading = true;
                    });
                    await context
                        .read<TransactionCubit>()
                        .updateTransaction(widget.transaction.copyWith(
                          status: (selectedStatus == 'Pesanan Baru')
                              ? TransactionStatus.pending
                              : (selectedStatus == 'Dibatalkan')
                                  ? TransactionStatus.cancelled
                                  : TransactionStatus.on_delivery,
                        ));
                    TransactionState state =
                        context.read<TransactionCubit>().state;

                    if (state is TransactionUpdated) {
                      Navigator.of(context).pop();
                      // context.read<TransactionCubit>().getTransactions(null);
                      Get.to(() => MainPage(
                            initialPage: 3,
                          ));
                      snackBar("Berhasil", "Status pesanan berhasil diupdate",
                          'success');

                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      Navigator.of(context).pop();
                      // context.read<TransactionCubit>().getTransactions(null);
                      context.read<UserCubit>().getMyProfile((context
                              .read<UserCubit>()
                              .state as UserLoadedWithShop)
                          .shop);
                      setState(() {
                        isLoading = false;
                      });
                      snackBar("Status pesanan gagal diupdate",
                          (state as TransactionUpdateFailed).message, 'error');
                    }
                  }, "Ubah", "Yakin status pesanan ini akan diubah?");
                }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  bool confirm(bool isConfirm) {
    if (isConfirm) {
      SweetAlert.show(context,
          subtitle: "Sedang memproses...", style: SweetAlertStyle.loading);
      new Future.delayed(new Duration(seconds: 0), () async {
        await context
            .read<PhotoCubit>()
            .destroyMultiple(widget.transaction.product, true);
        PhotoState state = context.read<PhotoCubit>().state;
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
