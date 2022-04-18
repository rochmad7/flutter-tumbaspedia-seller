part of 'models.dart';

class Photo extends Equatable {
  final int id;
  File imageFile;
  final String images;

  Photo({this.id, this.images, this.imageFile});

  factory Photo.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Photo(
        id: data["id"],
        images: data["picturePath"],
      );
    }
    return null;
  }

  Photo copyWith({
    int id,
    String images,
  }) {
    return Photo(
      id: id ?? this.id,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        id,
        images,
      ];
}

// Our demo Photos

List<Photo> mockPhotos = [
  Photo(
    id: 1,
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Photo(
    id: 2,
    images:
        "https://cdns.klimg.com/dream.co.id/resources/news/2020/04/06/133546/bikin-steak-di-rumah-pastikan-bumbunya-meresap-2004066.jpg",
  ),
  Photo(
    id: 3,
    images:
        "https://i1.wp.com/varminz.com/wp-content/uploads/2019/12/mexican-chopped-salad3.jpg?fit=843%2C843&ssl=1",
  ),
  Photo(
    id: 4,
    images:
        "https://www.carmudi.co.id/journal/wp-content/uploads/2018/05/car-rentals.jpg",
  ),
  Photo(
    id: 5,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
  ),
  Photo(
    id: 6,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
  ),
  Photo(
    id: 7,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
  ),
  Photo(
    id: 8,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
  ),
  Photo(
    id: 9,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
  ),
];
