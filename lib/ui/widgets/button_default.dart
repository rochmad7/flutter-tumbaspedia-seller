part of 'widgets.dart';

class ButtonDefault extends StatelessWidget {
  final Function press;
  final String title;
  final Color color;
  final bool isLoading;
  ButtonDefault({this.press, this.isLoading = false, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
      width: double.infinity,
      child: isLoading
          ? loadingIndicator
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15.0),
                primary: color != null ? color : mainColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: mainColor)),
              ),
              onPressed: press,
              child: Text(
                title,
                style: GoogleFonts.poppins().copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}

class ButtonIconDefault extends StatelessWidget {
  final Function press;
  final String title;
  final Color color;
  final double height;
  final bool isFullWidth;
  final bool isLoading;
  final bool isWhiteColor;
  final EdgeInsetsGeometry margin;
  final IconData icon;
  ButtonIconDefault({
    this.press,
    this.icon,
    this.margin,
    this.height = 50,
    this.isFullWidth = true,
    this.isWhiteColor = true,
    this.isLoading = false,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null
          ? margin
          : EdgeInsets.symmetric(horizontal: defaultMargin),
      height: height,
      width: isFullWidth ? double.infinity : null,
      child: isLoading
          ? loadingIndicator
          : ElevatedButton.icon(
              icon: Icon(
                icon,
                color: isWhiteColor ? Colors.white : mainColor,
              ),
              onPressed: press,
              style: ElevatedButton.styleFrom(
                  primary: color != null ? color : mainColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              label: Text(
                title,
                style: isWhiteColor
                    ? whiteFontStyle3.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 16)
                    : blackFontStyle3.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
    );
  }
}

class ButtonFlexible extends StatelessWidget {
  final Function press;
  final String title;
  final IconData icon;
  final double marginTop;
  final Color color;
  ButtonFlexible(
      {this.press, this.marginTop = 0, this.icon, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        width: double.infinity,
        height: 45,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 17,
          ),
          label: Text(title,
              style: whiteFontStyle3.copyWith(fontWeight: FontWeight.w500)),
          onPressed: press,
        ),
      ),
    );
  }
}
