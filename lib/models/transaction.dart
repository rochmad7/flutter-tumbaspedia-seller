part of 'models.dart';

enum TransactionStatus { delivered, on_delivery, pending, canceled }

class Transaction extends Equatable {
  final int id;
  final Product product;
  final Shop shop;
  final int quantity;
  final int total;
  final DateTime dateTime;
  final DateTime updateTime;
  final DateTime confirmedAt;
  final DateTime deliveredAt;
  final TransactionStatus status;
  final User user;

  Transaction({
    this.id,
    this.product,
    this.user,
    this.shop,
    this.quantity,
    this.total,
    this.dateTime,
    this.updateTime,
    this.confirmedAt,
    this.deliveredAt,
    this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
    id: data["id"],
    product:
    data["product"] != null ? Product.fromJson(data["product"]) : null,
    user: data["user"] != null ? User.fromJson(data["user"]) : null,
    shop: data["shop"] != null ? Shop.fromJson(data["shop"]) : null,
    quantity: data["quantity"],
    total: data["total"],
    dateTime: DateTime.parse(data["created_at"]),
    updateTime: DateTime.parse(data["updated_at"]),
    confirmedAt: data["confirmed_at"] != null
        ? DateTime.parse(data["created_at"])
        : null,
    deliveredAt: data["delivered_at"] != null
        ? DateTime.parse(data["updated_at"])
        : null,
    status: (data["status"] == 'pending')
        ? TransactionStatus.pending
        : (data['status'] == 'delivered')
        ? TransactionStatus.delivered
        : (data['status'] == 'canceled')
        ? TransactionStatus.canceled
        : TransactionStatus.on_delivery,
  );

  Transaction copyWith({
    int id,
    Shop shop,
    Product product,
    User user,
    int quantity,
    int total,
    DateTime dateTime,
    DateTime updateTime,
    DateTime confirmedAt,
    DateTime deliveredAt,
    TransactionStatus status,
  }) {
    return Transaction(
        id: id ?? this.id,
        shop: shop ?? this.shop,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        dateTime: dateTime ?? this.dateTime,
        updateTime: updateTime ?? this.updateTime,
        confirmedAt: confirmedAt ?? this.confirmedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [
    id,
    product,
    user,
    shop,
    quantity,
    total,
    dateTime,
    updateTime,
    confirmedAt,
    deliveredAt,
    status
  ];
}