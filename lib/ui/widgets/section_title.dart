part of 'widgets.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    this.press,
    this.isColor = false,
    this.all,
    this.sizeTitle = 17,
    this.defaultMargin = 24,
  }) : super(key: key);

  final String title;
  final double defaultMargin;
  final GestureTapCallback press;
  final bool all;
  final double sizeTitle;
  final bool isColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (isColor) ? Colors.white : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins().copyWith(
              fontSize: sizeTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
          all
              ? GestureDetector(
                  onTap: press,
                  child: Text(
                    "Lihat Semua",
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      color: Colors.orange,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
