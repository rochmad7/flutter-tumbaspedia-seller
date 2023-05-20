part of 'widgets.dart';

class LabelFormField extends StatelessWidget {
  final String label;
  final String example;
  final bool isMandatory;

  LabelFormField({this.label, this.example, this.isMandatory = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text(
          //   label,
          //   style: blackFontStyle2,
          // ),
          // isMandatory
          //     ? Text(
          //   '*',
          //   style: blackFontStyle2.copyWith(color: Colors.red),
          // )
          //     : SizedBox(),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: label,
                style: blackFontStyle2,
                children: [
                  TextSpan(
                    text: isMandatory ? ' *' : '',
                    style: blackFontStyle2.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
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
