part of '../pages.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Privacy & Policy',
      subtitle: 'Pernyataan Privasi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: List.generate(mockPrivacy.length, (index) {
          return CardAccordion(
              maxLines: 0,
              title: mockPrivacy[index].title,
              text: mockPrivacy[index].text);
        }),
      ),
    );
  }
}
