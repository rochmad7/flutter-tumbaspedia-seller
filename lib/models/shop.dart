part of 'models.dart';

class Shop extends Equatable {
  final int id;
  final String name, description;
  final String images;
  final String logo;
  final String nib;
  final String address;
  final double rating;
  final bool isValid;
  final bool isReject;
  final int sold;
  final int income;
  final int totalProducts;
  final bool status;
  final String openingHours;
  final String closedHours;

  Shop(
      {this.id,
      this.logo,
      this.nib,
      this.address,
      this.name,
      this.images,
      this.description,
      this.rating,
      this.sold,
      this.income,
      this.totalProducts,
      this.openingHours,
      this.closedHours,
      this.isReject,
      this.isValid,
      this.status});

  factory Shop.fromJson(Map<String, dynamic> data) => Shop(
        id: data["id"],
        logo: baseURLStorage + data["logo"],
        address: data["address"],
        name: data["name"],
        images: data["picturePath"],
        nib: data["nib"],
        openingHours: data["opening_hours"],
        closedHours: data["closed_hours"],
        sold: data["sold"] != null ? int.parse(data["sold"].toString()) : 0,
        income:
            data["income"] != null ? int.parse(data["income"].toString()) : 0,
        totalProducts: data["total_products"] != null
            ? int.parse(data["total_products"].toString())
            : 0,
        isValid: (int.parse(data["isValid"].toString()) == 0) ? false : true,
        isReject: (int.parse(data["isReject"].toString()) == 0) ? false : true,
        status: (int.parse(data["status"].toString()) == 0) ? false : true,
        description: data["description"],
        rating: data["rating"] != null
            ? double.parse(data["rating"].toString())
            : 0,
      );

  Shop copyWith(
          {int id,
          String logo,
          String address,
          String name,
          String images,
          String nib,
          int sold,
          int income,
          int totalProducts,
          String openingHours,
          String closedHours,
          bool isValid,
          bool isReject,
          bool status,
          String description,
          double rating}) =>
      Shop(
          id: id ?? this.id,
          logo: logo ?? this.logo,
          address: address ?? this.address,
          name: name ?? this.name,
          images: images ?? this.images,
          nib: nib ?? this.nib,
          sold: sold ?? this.sold,
          income: income ?? this.income,
          totalProducts: totalProducts ?? this.totalProducts,
          openingHours: openingHours ?? this.openingHours,
          closedHours: closedHours ?? this.closedHours,
          isValid: isValid ?? this.isValid,
          isReject: isReject ?? this.isReject,
          status: status ?? this.status,
          description: description ?? this.description,
          rating: rating ?? this.rating);

  @override
  List<Object> get props => [
        id,
        name,
        logo,
        nib,
        openingHours,
        closedHours,
        sold,
        income,
        totalProducts,
        isValid,
        isReject,
        status,
        address,
        images,
        description,
        rating
      ];
}

// Our demo Shops

List<Shop> mockShops = [
  Shop(
    id: 1,
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    name: "Sate Sayur Sultan",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    rating: 4.1,
  ),
  Shop(
    id: 2,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Outlet Kerajinan Semarang",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Berbagai produk rumah tangga yang terbuat dari rotan, harga terjangkau, kualitas berani diadu",
    rating: 4.1,
  ),
  Shop(
    id: 3,
    images:
        "https://www.carmudi.co.id/journal/wp-content/uploads/2018/05/car-rentals.jpg",
    name: "Sewa Mobil Semarang",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Sewa mobil harian plus driver Semarang, Jawa Tengah. Melayani penjemputan dan pengantaran, travelling, business trip",
    rating: 4.1,
  ),
  Shop(
    id: 4,
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    name: "Mahkota Snack",
    address: "Jl. Watukaji Raya No.16 RT 3 RW 8 Gedawang",
    description: "Mahkota Snack",
    rating: 4.1,
  ),
];
