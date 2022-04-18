part of 'models.dart';

enum UserRole { admin, user, ukm, pengurus }

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String picturePath;
  static String token;

  User(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phoneNumber,
      this.picturePath});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data["id"],
        name: data["name"],
        email: data["email"],
        address: data["address"],
        phoneNumber: data["phoneNumber"],
        picturePath: baseURLStorage + data["profile_photo_path"],
      );

  User copyWith({
    int id,
    String name,
    String email,
    String address,
    String phoneNumber,
    String picturePath,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        picturePath: picturePath ?? this.picturePath,
      );

  @override
  List<Object> get props => [
        id,
        name,
        email,
        address,
        phoneNumber,
        picturePath,
      ];
}

User mockUser = User(
    id: 1,
    name: 'Hello World',
    address: 'Jalan Jenderal Sudirman',
    phoneNumber: '08123456789',
    email: 'hello@gmail.com',
    picturePath:
        'https://i.pinimg.com/474x/8a/f4/7e/8af47e18b14b741f6be2ae499d23fcbe.jpg');
