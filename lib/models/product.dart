part of 'models.dart';

enum ProductType { baru, populer, recommended }

class Product extends Equatable {
  //coba
  // final Shop shop;
  final Category category;
  final String name;
  final int id;
  final String description;
  final int stock;
  final String images;
  final double rating;
  final int price;
  final int sold;
  final int totalReview;
  final ProductType types;

  Product({
    this.id,
    //coba
    // this.shop,
    this.category,
    this.name,
    this.images,
    this.description,
    this.stock,
    this.price,
    this.sold,
    this.totalReview,
    this.rating,
    this.types,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Product(
        id: data["id"],
        category: Category.fromJson(data["category"]),
        name: data["name"],
        images: data["picturePath"],
        description: data["description"],
        price: data["price"] != null ? int.parse(data["price"].toString()) : 0,
        totalReview: data["total_review"] != null
            ? int.parse(data["total_review"].toString())
            : 0,
        sold: data["sold"] != null ? int.parse(data["sold"].toString()) : 0,
        stock: data["stock"] != null ? int.parse(data["stock"].toString()) : 0,
        rating: data["rating"] != null
            ? double.parse(data["rating"].toString())
            : 0.0,
        types: (data['types'] == 'recommended')
            ? ProductType.recommended
            : (data['types'] == 'new')
                ? ProductType.baru
                : (data['types'] == 'populer')
                    ? ProductType.populer
                    : null,
      );
    }
    return null;
  }

  Product copyWith({
    int id,
    Category category,
    String name,
    String images,
    String description,
    int stock,
    int price,
    int totalReview,
    int sold,
    double rating,
    ProductType types,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      images: images ?? this.images,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      totalReview: totalReview ?? this.totalReview,
      sold: sold ?? this.sold,
      rating: rating ?? this.rating,
      types: types ?? this.types,
    );
  }

  @override
  List<Object> get props => [
        id,
        category,
        name,
        images,
        description,
        stock,
        totalReview,
        price,
        sold,
        rating,
        types,
      ];
}

// Our demo Products

List<Product> mockProducts = [
  Product(
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    name: "Sate Sayur Sultan",
    price: 20000,
    sold: 12,
    description:
        "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    rating: 4.1,
    stock: 5,
    types: ProductType.recommended,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://cdns.klimg.com/dream.co.id/resources/news/2020/04/06/133546/bikin-steak-di-rumah-pastikan-bumbunya-meresap-2004066.jpg",
    name: "Steak Daging Sapi Korea",
    price: 25000,
    sold: 3,
    description:
        "Daging sapi Korea adalah jenis sapi paling premium di Korea. Namun, untuk menikmatinya Anda tidak perlu jauh-jauh ke Korea Selatan. Steak Sapi Korea Oppa Bandung ini sudah terkenal di seluruh Indonesia dan sudah memiliki lebih dari 2 juta cabang.",
    rating: 4.5,
    stock: 8,
    types: ProductType.populer,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://i1.wp.com/varminz.com/wp-content/uploads/2019/12/mexican-chopped-salad3.jpg?fit=843%2C843&ssl=1",
    name: "Mexican Chopped Salad",
    price: 25000,
    sold: 6,
    description:
        "Salad ala mexico yang kaya akan serat dan vitamin. Seluruh bahan diambil dari Mexico sehingga akan memiliki cita rasa yang original.",
    rating: 4.7,
    stock: 10,
    types: ProductType.baru,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://www.carmudi.co.id/journal/wp-content/uploads/2018/05/car-rentals.jpg",
    name: "Sewa Mobil Semarang",
    price: 450000,
    sold: 8,
    description:
        "Sewa mobil harian plus driver Semarang, Jawa Tengah. Melayani penjemputan dan pengantaran, travelling, business trip",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[2],
  ),
  Product(
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Kerajinan Rotan Kotak Tisu",
    price: 40000,
    sold: 5,
    description:
        "Berbagai produk rumah tangga yang terbuat dari rotan, harga terjangkau, kualitas berani diadu",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[1],
  ),
  Product(
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Wingko Babat Mahkota Snack",
    price: 2500,
    sold: null,
    description: "Wingko Babat Mahkota Snack",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Kue Lumpur Mahkota Snack",
    price: 2000,
    sold: null,
    description: "Kue Lumpur Mahkota Snack",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Klepon Mahkota Snack",
    price: 2000,
    sold: null,
    description: "Klepon Mahkota Snack",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[0],
  ),
  Product(
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Pastel Rogout Mahkota Snack",
    price: 2500,
    sold: null,
    description: "Pastel Rogout Mahkota Snack",
    rating: 4.4,
    types: ProductType.recommended,
    category: mockCategories[0],
  ),
];
