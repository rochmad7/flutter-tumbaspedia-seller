part of 'widgets.dart';

class LabelFormField extends StatelessWidget {
  final String label;
  final String example;

  LabelFormField({this.label, this.example});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: blackFontStyle2,
          ),
          (example != null)
              ? Text(example,
                  style: blackFontStyle3.copyWith(fontSize: 12),
                  textAlign: TextAlign.right)
              : SizedBox(),
        ],
      ),
    );
  }
}
