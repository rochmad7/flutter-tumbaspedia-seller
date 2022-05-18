part of 'models.dart';

enum TransactionStatus { delivered, on_delivery, pending, cancelled }

class Transaction extends Equatable {
  final int id;
  final Product product;
  final Shop shop;
  final int quantity;
  final int total;
  final DateTime dateTime;
  final DateTime confirmedAt;
  final DateTime deliveredAt;
  final TransactionStatus status;
  final User user;

  Transaction({
    this.id,
    this.product,
    this.shop,
    this.quantity,
    this.total,
    this.dateTime,
    this.confirmedAt,
    this.deliveredAt,
    this.status,
    this.user,
  });

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
        id: data["id"],
        // shop: Shop.fromJson(data["shop"]),
        product: Product.fromJson(data["product"]),
        user: User.fromJson(data["user"]),
        quantity: int.parse(data["quantity"].toString()),
        total: int.parse(data["total"].toString()),
        dateTime: DateTime.fromMillisecondsSinceEpoch(data["created_at"]),
        confirmedAt: data["confirmed_at"] != null
            ? DateTime.fromMillisecondsSinceEpoch(data["created_at"])
            : null,
        deliveredAt: data["delivered_at"] != null
            ? DateTime.fromMillisecondsSinceEpoch(data["updated_at"])
            : null,
        status: (data["status"] == 'PENDING')
            ? TransactionStatus.pending
            : (data['status'] == 'DELIVERED')
                ? TransactionStatus.delivered
                : (data['status'] == 'CANCELLED')
                    ? TransactionStatus.cancelled
                    : TransactionStatus.on_delivery,
      );

  Transaction copyWith(
      {int id,
      Shop shop,
      Product product,
      int quantity,
      int total,
      DateTime dateTime,
      DateTime confirmedAt,
      DateTime deliveredAt,
      TransactionStatus status,
      User user}) {
    return Transaction(
        id: id ?? this.id,
        shop: shop ?? this.shop,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        dateTime: dateTime ?? this.dateTime,
        confirmedAt: confirmedAt ?? this.confirmedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [
        id,
        shop,
        product,
        quantity,
        confirmedAt,
        deliveredAt,
        total,
        dateTime,
        status,
        user
      ];
}