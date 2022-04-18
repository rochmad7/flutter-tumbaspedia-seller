part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;

  CustomTabBar({this.selectedIndex, this.titles, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            height: 1,
            color: "F2F2F2".toColor(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: titles
                .map((e) => Container(
                      margin: EdgeInsets.only(
                        left: defaultMargin,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (onTap != null) {
                                onTap(titles.indexOf(e));
                              }
                            },
                            child: Text(
                              e,
                              style: (titles.indexOf(e) == selectedIndex)
                                  ? blackFontStyle3.copyWith(
                                      fontWeight: FontWeight.w500,
                                    )
                                  : greyFontStyle,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 3,
                            margin: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5),
                              color: (titles.indexOf(e) == selectedIndex)
                                  ? "020202".toColor()
                                  : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class ItemTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final Category category;
  final double left;
  final double right;

  ItemTabBar(
      {this.selectedIndex, this.onTap, this.category, this.left, this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(category.id);
              }
            },
            child: Text(
              category.name,
              style: (category.id == selectedIndex)
                  ? blackFontStyle3.copyWith(
                      fontWeight: FontWeight.w500,
                    )
                  : greyFontStyle,
            ),
          ),
          Container(
            width: 40,
            height: 3,
            margin: EdgeInsets.only(top: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.5),
              color: (category.id == selectedIndex)
                  ? "020202".toColor()
                  : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
