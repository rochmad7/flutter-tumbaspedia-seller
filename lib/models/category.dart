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
        icon: data["icon"],
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