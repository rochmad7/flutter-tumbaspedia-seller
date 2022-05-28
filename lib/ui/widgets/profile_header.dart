part of 'widgets.dart';

class ProfileHeader extends StatefulWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final List<Widget> actions;
  final bool status;
  final String shopOpenHours;
  final String shopClosedHours;

  const ProfileHeader(
      {Key key,
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
    bool isSwitched = widget.status ?? false;
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: widget.coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (widget.actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.actions,
            ),
          ),
        Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(bottom: 10, left: 10),
          alignment: Alignment.bottomLeft,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                child: FlutterSwitch(
                  width: 70.0,
                  height: 25.0,
                  toggleSize: 15.0,
                  activeText: "Buka",
                  inactiveText: "Tutup",
                  showOnOff: true,
                  valueFontSize: 12,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  value: isSwitched,
                  onToggle: (value) {
                    SweetAlert.show(context,
                        title: "Apakah Anda yakin?",
                        subtitle:
                            "Toko Anda akan " + (isSwitched ? "tutup" : "buka"),
                        style: SweetAlertStyle.confirm,
                        confirmButtonText: "Ya",
                        cancelButtonText: "Batal",
                        // ignore: missing_return
                        showCancelButton: true, onPress: (bool isConfirm) {
                      if (isConfirm) {
                        // context.read<UserCubit>().changeStatus(value);
                        SweetAlert.show(context,
                            style: SweetAlertStyle.success, title: "Berhasil");
                        setState(() {
                          isSwitched = value;
                        });
                        return false;
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: widget.avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(widget.title,
                  style: blackFontStyle1.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jam Buka:",
                          style: titleListStyle,
                        ),
                        Text(
                          "Jam Tutup:",
                          style: titleListStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.shopOpenHours + " WIB",
                          style: blackFontStyle3,
                        ),
                        Text(
                          widget.shopClosedHours + " WIB",
                          style: blackFontStyle3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
