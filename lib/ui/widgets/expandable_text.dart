part of 'widgets.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final Widget header;
  final int maxLines;
  ExpandableText({this.header, this.text, this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Column(
        children: [
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
                tapBodyToExpand: true,
                tapHeaderToExpand: true,
              ),
              header: header,
              collapsed: LayoutBuilder(builder: (context, size) {
                final span = TextSpan(text: text, style: blackFontStyle);
                final tp = TextPainter(
                    text: span,
                    textDirection: TextDirection.ltr,
                    maxLines: maxLines);
                tp.layout(maxWidth: size.maxWidth);

                if (tp.didExceedMaxLines) {
                  return CustomPaint(
                    foregroundPainter: FadingEffect(),
                    child: Text(
                      text,
                      maxLines: maxLines,
                      style: blackFontStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                } else {
                  return Text(text, style: blackFontStyle);
                }
              }),
              expanded: Text(
                text,
                style: blackFontStyle,
              ),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FadingEffect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    LinearGradient lg = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          //create 2 white colors, one transparent
          Color.fromARGB(0, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255)
        ]);
    Paint paint = Paint()..shader = lg.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(FadingEffect linePainter) => false;
}
