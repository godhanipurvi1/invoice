

class Item {
  final String name;
  final double price;
  final int quantity;

  Item({
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class Invoice {
  final String id;
  final List<Item> items;

  Invoice({
    required this.id,
    required this.items,
  });

  double get total => items.fold(0.0, (sum, item) => sum + item.total);
}
