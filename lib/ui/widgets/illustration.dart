part of 'widgets.dart';

class Illustration extends StatelessWidget {
  final String picturePath;
  final String title;
  final String subtitle;

  Illustration({this.picturePath, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(picturePath))),
          ),
          Text(
            title,
            style: blackFontStyle3.copyWith(fontSize: 30),
          ),
          Text(
            subtitle,
            style: greyFontStyle.copyWith(
                fontWeight: FontWeight.w400, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomIllustration extends StatelessWidget {
  final String picturePath;
  final String title;
  final String subtitle;
  final bool isIllustration;
  final double marginBottom;
  final double sizeTitle;
  final double sizeSubTitle;

  CustomIllustration(
      {this.marginBottom = 30,
      this.sizeSubTitle = 16,
      this.isIllustration = true,
      this.sizeTitle = 30,
      this.picturePath,
      this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIllustration
              ? Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(bottom: marginBottom),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(picturePath))),
                )
              : SizedBox(),
          Text(
            title,
            style: blackFontStyle3.copyWith(fontSize: sizeTitle),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: greyFontStyle.copyWith(
                fontWeight: FontWeight.w400, fontSize: sizeSubTitle),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
