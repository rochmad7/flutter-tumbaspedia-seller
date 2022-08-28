part of 'widgets.dart';

class RefreshButton extends StatelessWidget {
  final Function press;
  final bool isLabel;
  RefreshButton({this.press, this.isLabel = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        focusColor: Colors.white,
        highlightColor: Colors.white,
        hoverColor: Colors.white,
        splashColor: Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 12),
          child: Row(
            children: [
              isLabel ? Text('Refresh', style: blackFontStyle3) : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.refresh, color: mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
