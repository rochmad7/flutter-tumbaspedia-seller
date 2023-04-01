part of 'widgets.dart';

class ProfileHeader extends StatefulWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final List<Widget> actions;
  final bool status;
  final String shopOpenHours;
  final String shopClosedHours;
  final int shopId;

  const ProfileHeader(
      {Key key,
      this.shopId,
      this.status,
      this.shopOpenHours,
      this.shopClosedHours,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.actions})
      : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            image: DecorationImage(image: widget.coverImage, fit: BoxFit.cover),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
        ),
        if (widget.actions != null)
          Positioned(
            top: 30,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions,
            ),
          ),
        Positioned(
          left: 16,
          bottom: 16,
          child: Avatar(
            image: widget.avatar,
            radius: 40,
            backgroundColor: Colors.white,
            borderColor: Colors.grey.shade300,
            borderWidth: 4.0,
          ),
        ),
        // Positioned(
        //   left: 80,
        //   bottom: 50,
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.schedule,
        //         size: 14.0,
        //         color: Colors.white,
        //       ),
        //       SizedBox(width: 5),
        //       Text(
        //         "${widget.shopOpenHours.substring(0, 5)} - ${widget.shopClosedHours.substring(0, 5)}",
        //         style: whiteFontStyle,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
