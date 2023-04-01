part of 'widgets.dart';

class TitlePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onBackButtonPressed;
  final Function press;
  final bool isContainer;
  final bool isContainerRight;
  final Widget child;
  final int count;
  TitlePage(
      {this.title,
      this.isContainer = false,
      this.isContainerRight = false,
      this.child,
      this.count = 0,
      this.press,
      this.onBackButtonPressed,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // HEADER
        Container(
          padding: isContainerRight && count != 0
              ? EdgeInsets.only(right: defaultMargin)
              : EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: isContainerRight && count != 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              onBackButtonPressed != null
                  ? GestureDetector(
                      onTap: () {
                        if (onBackButtonPressed != null) {
                          onBackButtonPressed();
                        }
                      },
                      child: Container(
                        width: defaultMargin,
                        height: defaultMargin,
                        margin: EdgeInsets.only(right: 26),
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage("assets/icons/back_arrow.png"),
                        //   ),
                        // ),
                        child: Icon(MdiIcons.arrowLeft),
                      ),
                    )
                  : Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: blackFontStyle1,
                  ),
                  Text(
                    subtitle,
                    style: greyFontStyle.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              isContainerRight && count != 0
                  ? InkWell(
                      onTap: press,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.notifications),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                alignment: Alignment.center,
                                child: Text(count.toString(),
                                    style:
                                        whiteFontStyle3.copyWith(fontSize: 10)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
        !isContainer
            ? SizedBox()
            : Container(
                height: defaultMargin,
                width: double.infinity,
                color: "FAFAFC".toColor(),
              ),
        child ?? SizedBox(),
      ],
    );
  }
}
