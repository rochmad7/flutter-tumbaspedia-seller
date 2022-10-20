part of 'models.dart';

class Shop extends Equatable {
  final int id;
  final String name, description;
  final String images;
  final String address;
  final bool isValid;

  // final int totalProducts;
  final int rating;
  final String openingHours;
  final String closedHours;
  final bool status;
  final String nib;
  final String nibNumber;

  Shop(
      {this.id,
      this.address,
      this.name,
      this.images,
      this.description,
      this.rating,
      // this.totalProducts,
      this.openingHours,
      this.closedHours,
      this.status = true,
      this.isValid,
      this.nib,
      this.nibNumber});

  factory Shop.fromJson(Map<String, dynamic> data) => Shop(
        id: data["id"],
        address: data["address"],
        name: data["name"],
        images: data["shop_picture"],
        openingHours: data["opened_at"],
        closedHours: data["closed_at"],
        // totalProducts: data["total_products"] != null
        //     ? int.parse(data["total_products"].toString())
        //     : 0,
        status: data["is_open"] == true ? true : false,
        isValid: data["is_verified"] == true ? true : false,
        description: data["description"],
        nib: data["nib"],
        nibNumber: data["nib_number"],
      );

  Shop copyWith(
          {int id,
          String address,
          String name,
          String images,
          // int totalProducts,
          String openingHours,
          String closedHours,
          bool isValid,
          bool status,
          String description,
          double rating,
          String nib,
          String nibNumber}) =>
      Shop(
          id: id ?? this.id,
          address: address ?? this.address,
          name: name ?? this.name,
          images: images ?? this.images,
          // totalProducts: totalProducts ?? this.totalProducts,
          openingHours: openingHours ?? this.openingHours,
          closedHours: closedHours ?? this.closedHours,
          isValid: isValid ?? this.isValid,
          status: status ?? this.status,
          description: description ?? this.description,
          rating: rating ?? this.rating,
          nib: nib ?? this.nib,
          nibNumber: nibNumber ?? this.nibNumber);

  @override
  List<Object> get props => [
        id,
        name,
        openingHours,
        closedHours,
        // totalProducts,
        isValid,
        rating,
        address,
        images,
        status,
        description,
        nib,
        nibNumber
      ];
}
