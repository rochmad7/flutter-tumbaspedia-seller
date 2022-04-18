part of 'widgets.dart';

class CommentRating extends StatelessWidget {
  final Rating rating;
  CommentRating({this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: greyColor, width: 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13.0),
        child: ExpandableNotifier(
          child: rating.review == null
              ? commentContent(context)
              : Column(
                  children: [
                    ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                          tapHeaderToExpand: true,
                          tapBodyToExpand: true,
                        ),
                        header: commentContent(context),
                        collapsed: Container(
                          padding: EdgeInsets.only(right: 13.0),
                          child: Text(
                            rating.review,
                            maxLines: 2,
                            style: blackFontStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        expanded: Container(
                          padding: EdgeInsets.only(right: 13.0),
                          child: Text(
                            rating.review,
                            style: blackFontStyle,
                          ),
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
                    SizedBox(height: 12.0),
                  ],
                ),
        ),
      ),
    );
  }

  Column commentContent(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://ui-avatars.com/api/?name=" + rating.name),
                    radius: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 170,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        rating.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: blackFontStyle.copyWith(
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingStars(
                                      rate: rating.rating, isText: true),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      timeago.format(rating.createdAt),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          greyFontStyle.copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
