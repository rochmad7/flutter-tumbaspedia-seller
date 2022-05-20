part of 'models.dart';

enum ProductType { baru, populer, recommended }

class Product extends Equatable {
  // final Shop shop;
  final Category category;
  final String name, description;
  final int id, stock;
  final String images;
  final double rating;
  final int price;
  final int totalReview;
  final int sold;
  final ProductType types;

  Product({
    this.id,
    // this.shop,
    this.category,
    this.name,
    this.images,
    this.description,
    this.stock,
    this.price,
    this.totalReview,
    this.sold,
    this.rating,
    this.types,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Product(
        id: data["id"],
        // shop: data["shop"] != null ? Shop.fromJson(data["shop"]) : null,
        category: data["category"] != null
            ? Category.fromJson(data["category"])
            : null,
        name: data["name"],
        images: data["product_picture"],
        description: data["description"],
        stock: data["stock"] ,
        price: data["price"],
        totalReview: data["total_review"] != null
            ? int.parse(data["total_review"].toString())
            : 0,
        sold: data["sold"] != null ? int.parse(data["sold"].toString()) : 0,
        rating: data["rating"] != null
            ? double.parse(data["rating"].toString())
            : 0.0,
        types: (data['types'] == 'recommended')
            ? ProductType.recommended
            : (data['types'] == 'new')
            ? ProductType.baru
            : ProductType.populer,
      );
    }
    return null;
  }

  Product copyWith(
      {int id,
        Shop shop,
        Category category,
        String name,
        String images,
        String description,
        int stock,
        int price,
        int totalReview,
        int sold,
        double rating,
        ProductType types}) {
    return Product(
        id: id ?? this.id,
        // shop: shop ?? this.shop,
        category: category ?? this.category,
        name: name ?? this.name,
        images: images ?? this.images,
        description: description ?? this.description,
        stock: stock ?? this.stock,
        price: price ?? this.price,
        totalReview: totalReview ?? this.totalReview,
        sold: sold ?? this.sold,
        rating: rating ?? this.rating,
        types: types ?? this.types);
  }

  @override
  List<Object> get props => [
    id,
    // shop,
    category,
    name,
    images,
    description,
    stock,
    price,
    totalReview,
    sold,
    rating,
    types,
  ];
}
