part of 'widgets.dart';

class ShimmerTwo extends StatelessWidget {
  final int itemCount;
  final double ratio;
  ShimmerTwo({this.itemCount, this.ratio});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemCount: itemCount,
          // Important code
          itemBuilder: (context, index) => CardShimmer(ratio: ratio),
        ));
  }
}

class CardShimmer extends StatelessWidget {
  final double ratio;
  final bool isCircular;
  final bool isSymmetric;
  final double height;
  CardShimmer(
      {this.ratio = 1.0,
      this.isCircular = false,
      this.isSymmetric = true,
      this.height});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
        child: isSymmetric
            ? AspectRatio(
                aspectRatio: ratio,
                child: ClipRRect(
                  borderRadius: isCircular
                      ? BorderRadius.circular(15)
                      : BorderRadius.circular(0),
                  child: Container(
                    color: Colors.grey[200],
                  ),
                ),
              )
            : Container(
                height: height,
                child: ClipRRect(
                  borderRadius: isCircular
                      ? BorderRadius.circular(15)
                      : BorderRadius.circular(0),
                  child: Container(color: Colors.grey[200]),
                ),
              ));
  }
}
