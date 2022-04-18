part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double rate;
  final bool isText;

  RatingStars({this.rate, this.isText = true});

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rate.round();
    return Row(
      children: !isText
          ? generateStars(numberOfStars)
          : generateStars(numberOfStars) +
              [
                SizedBox(
                  width: 4,
                ),
                Text(
                  rate.toString(),
                  style: greyFontStyle.copyWith(fontSize: 12),
                )
              ],
    );
  }

  List<Widget> generateStars(int numberOfStars) {
    return List<Widget>.generate(
        5,
        (index) => Icon(
              (index < numberOfStars) ? MdiIcons.star : MdiIcons.starOutline,
              size: 16,
              color: secondaryColor,
            ));
  }
}
