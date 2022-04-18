part of 'widgets.dart';

class UserInfo extends StatelessWidget {
  final User user;

  UserInfo({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "Informasi Penjual",
              style: sectionTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.person),
                            title: Text("Nama", style: titleListStyle),
                            subtitle: Text(
                              user.name,
                              style: textListStyle,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            leading: Icon(Icons.email),
                            title: Text("Email", style: titleListStyle),
                            subtitle: Text(user.email, style: textListStyle),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 12, top: 10),
                            leading: Icon(Icons.phone),
                            title: Text("No Hp", style: titleListStyle),
                            subtitle:
                                Text(user.phoneNumber, style: textListStyle),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
