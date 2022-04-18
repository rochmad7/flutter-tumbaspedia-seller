part of '../pages.dart';

class PaymentInstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Pembayaran',
      subtitle: 'Tata cara menggunakan aplikasi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(),
    );
  }
}
