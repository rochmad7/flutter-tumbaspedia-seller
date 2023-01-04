part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String picturePath;
  final String buttonTitle1;
  final String buttonTitle2;
  final Function buttonTap1;
  final Function buttonTap2;
  final double sizeTitle;
  final bool isBackHome;

  IllustrationPage(
      {@required this.title,
      @required this.subtitle,
      @required this.picturePath,
      this.sizeTitle = 30,
      this.buttonTap1,
      this.buttonTap2,
      this.buttonTitle1,
      this.buttonTitle2,
      this.isBackHome = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(picturePath))),
          ),
          Text(
            title,
            style: blackFontStyle3.copyWith(fontSize: sizeTitle),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: greyFontStyle.copyWith(
                fontWeight: FontWeight.w400, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          (buttonTap1 == null)
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.only(top: 30, bottom: 12),
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: buttonTap1,
                    child: Text(
                      buttonTitle1,
                      style:
                          whiteFontStyle3.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
          (buttonTap2 == null)
              ? SizedBox()
              : SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: '8D92A3'.toColor(),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: buttonTap2,
                    child: Text(
                      buttonTitle2 ?? 'title',
                      style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
          isBackHome
              ? TextUnderButton(
                  title: "",
                  subtitle: "<- Kembali",
                  press: () => Get.to(
                        () => SignInPage(),
                      ))
              : SizedBox()
        ],
      ),
    );
  }
}
