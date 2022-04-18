part of 'widgets.dart';

class ShimmerOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      // Important code
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[400],
          highlightColor: Colors.white,
          child: CardShimmer()),
    );
  }
}

class ShimmerRow extends StatelessWidget {
  final double ratio;
  final int itemCount;
  final Color color;
  final bool isSymmetric;
  final bool isNoMargin;
  final double height;
  ShimmerRow(
      {this.ratio = 1.0,
      this.isNoMargin = false,
      this.color = Colors.white,
      this.itemCount = 2,
      this.isSymmetric = true,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin:
          isNoMargin ? null : EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(itemCount, (index) {
            return Row(
              children: [
                SizedBox(width: index == 0 ? 0 : 10),
                Container(
                    width:
                        (MediaQuery.of(context).size.width * ratio / itemCount),
                    child: CardShimmer(
                      ratio: ratio,
                      isCircular: true,
                      isSymmetric: isSymmetric,
                      height: height,
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }
}
