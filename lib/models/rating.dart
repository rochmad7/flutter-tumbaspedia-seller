part of 'models.dart';

class Rating extends Equatable {
  final int id;
  final String name;
  final double rating;
  final String review;
  final DateTime createdAt;

  Rating({this.id, this.name, this.rating, this.review, this.createdAt});

  factory Rating.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Rating(
        id: data["id"],
        name: data["name"],
        rating: data["rating"] != null
            ? double.parse(data["rating"].toString())
            : 0.0,
        review: data["review"] ??= null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(data["created_at"]),
      );
    }
    return null;
  }

  Rating copyWith({
    int id,
    String images,
  }) {
    return Rating(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        rating,
        review,
        createdAt,
      ];
}

// Our demo Ratings

List<Rating> mockRatings = [
  Rating(
      id: 1,
      rating: 4.5,
      name: "Test",
      review: "Bagus",
      createdAt: DateTime.now()),
  Rating(
      id: 2,
      rating: 4.5,
      name: "Hello",
      review: "Bagus sekali",
      createdAt: DateTime.now()),
  Rating(
      id: 3,
      rating: 4.5,
      name: "123",
      review: "Keren",
      createdAt: DateTime.now()),
];
