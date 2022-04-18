part of '../pages.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Security',
      subtitle: 'Tata cara menggunakan aplikasi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(),
    );
  }
}
