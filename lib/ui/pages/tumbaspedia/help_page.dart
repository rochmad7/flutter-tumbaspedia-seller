part of '../pages.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Bantuan',
      subtitle: 'Bantuan untuk pengguna',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          CardAccordion(
              title: "Memproses Pesanan Produk/Jasa", text: prosespesanan),
          CardAccordion(title: "Status Pesanan Saat Ini", text: statuspesanan),
          CardAccordion(
              title: "Apa itu Tanda Notifikasi Berwarna Merah di Transaksi?",
              text: tandamerah),
          CardAccordion(title: "Cara Membuat Akun", text: buatakun),
          CardAccordion(title: "Bantuan Permasalahan", text: help),
        ],
      ),
    );
  }
}
