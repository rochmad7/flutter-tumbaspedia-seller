part of '../pages.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
        title: 'Tentang Kami',
        subtitle: 'Tumbaspedia dan Gerai Kopimi',
        onBackButtonPressed: () {
          Get.back();
        },
        child: Column(
          children: [
            CardAccordion(title: "Apa itu Tumbaspedia", text: tumbaspedia),
            CardAccordion(title: "Apa itu Gerai Kopimi", text: kopimi),
          ],
        ));
  }
}

class CardAccordion extends StatelessWidget {
  final int maxLines;
  final String text;
  final String title;
  CardAccordion({this.text, this.maxLines = 4, this.title});

  @override
  Widget build(BuildContext context) {
    // return ExpandableNotifier(
    //     child: Padding(
    //   padding: const EdgeInsets.all(10),
    //   child: Card(
    //     clipBehavior: Clip.antiAlias,
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 5,
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: mainColor,
    //               shape: BoxShape.rectangle,
    //             ),
    //           ),
    //         ),
    //         ScrollOnExpand(
    //           scrollOnExpand: true,
    //           scrollOnCollapse: false,
    //           child: ExpandablePanel(
    //             theme: const ExpandableThemeData(
    //               headerAlignment: ExpandablePanelHeaderAlignment.center,
    //               tapBodyToCollapse: true,
    //             ),
    //             header: Padding(
    //                 padding: EdgeInsets.all(10),
    //                 child: Text(
    //                   title,
    //                   style: sectionTitleStyle.copyWith(fontSize: 15),
    //                 )),
    //             collapsed: maxLines != 0
    //                 ? Text(
    //                     text,
    //                     softWrap: true,
    //                     maxLines: maxLines,
    //                     style: blackFontStyle,
    //                     overflow: TextOverflow.ellipsis,
    //                   )
    //                 : SizedBox(),
    //             expanded: Padding(
    //                 padding: EdgeInsets.only(bottom: 10),
    //                 child: Text(
    //                   text,
    //                   softWrap: true,
    //                   style: blackFontStyle,
    //                   overflow: TextOverflow.fade,
    //                 )),
    //             builder: (_, collapsed, expanded) {
    //               return Padding(
    //                 padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //                 child: Expandable(
    //                   collapsed: collapsed,
    //                   expanded: expanded,
    //                   theme: const ExpandableThemeData(crossFadePoint: 0),
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: sectionTitleStyle.copyWith(fontSize: 18),
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  text,
                  softWrap: true,
                  style: blackFontStyle,
                  overflow: TextOverflow.fade,
                )),
          ],
        ),
      ),
    );
  }
}
