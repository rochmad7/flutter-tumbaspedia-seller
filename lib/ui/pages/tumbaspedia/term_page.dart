part of '../pages.dart';

class TermPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Term & Service',
      subtitle: 'Syarat & kondisi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(),
    );
  }
}
