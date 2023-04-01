part of 'widgets.dart';

class ShopInfo extends StatelessWidget {
  final Shop shop;

  ShopInfo({this.shop});

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
              "Informasi Toko",
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
                                horizontal: 12, vertical: 8),
                            leading: Icon(Icons.shop),
                            title: Text(
                              "Nama Toko",
                              style: titleListStyle,
                            ),
                            subtitle: Text(
                              shop.name,
                              style: textListStyle,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(MdiIcons.mapMarker),
                            title: Text("Alamat", style: titleListStyle),
                            subtitle: Text(shop.address, style: textListStyle),
                          ),
                          ListTile(
                            contentPadding:
                            EdgeInsets.only(left: 12, right: 12, top: 10),
                            leading: Icon(Icons.schedule),
                            title: Text("Jam Buka-Tutup", style: titleListStyle),
                            subtitle: Text(
                              "${shop.openingHours} - ${shop.closedHours}",
                              style: textListStyle,
                            ),
                          ),
                          ListTile(
                            contentPadding:
                            EdgeInsets.only(left: 12, right: 12, top: 10),
                            leading: Icon(Icons.description),
                            title: Text("Deskripsi", style: titleListStyle),
                            subtitle:
                            Text(shop.description, style: textListStyle),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.confirmation_number),
                            title: Text("No. NIB", style: titleListStyle),
                            subtitle: Text(shop.nibNumber, style: textListStyle),
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
