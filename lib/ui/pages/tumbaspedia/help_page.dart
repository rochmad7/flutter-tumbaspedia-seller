part of '../pages.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Bantuan',
      subtitle: 'Bantuan Permasalahan yang Sering Terjadi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          CardAccordion(
              title: "Memproses Pesanan Produk UMKM", text: prosesPesanan),
          CardAccordion(title: "Informasi tentang Status Pesanan", text: statusPesanan),
          CardAccordion(
              title: "Fungsi Tanda Notifikasi Berwarna Merah",
              text: tandaMerah),
          CardAccordion(title: "Cara Membuat Akun", text: buatAkun),
          CardAccordion(title: "Bantuan Permasalahan", text: help),
        ],
      ),
    );
  }
}
