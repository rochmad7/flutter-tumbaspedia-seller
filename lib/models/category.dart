part of 'models.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String icon;

  Category({this.id, this.name, this.icon});

  factory Category.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Category(
        id: data["id"],
        name: data["name"],
        icon: baseURLStorage + data["icon"],
      );
    }
    return null;
  }

  Category copyWith({
    int id,
    String name,
    String icon,
  }) {
    return Category(
        id: id ?? this.id, name: name ?? this.name, icon: icon ?? this.icon);
  }

  @override
  List<Object> get props => [id, name, icon];
}

// Our demo Category

List<Category> mockCategories = [
  Category(
    id: 0,
    name: "Semua",
    icon: baseURLStorage + "assets/img/category/default.svg",
  ),
  Category(
    id: 1,
    name: "Kuliner",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 2,
    name: "Handicraft",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 3,
    name: "Jasa",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 4,
    name: "Toiletris",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 5,
    name: "Kosmetik",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 6,
    name: "Herbal",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 1,
    name: "Toko",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Category(
    id: 1,
    name: "Lain",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
];
