class Product {
  String id;
  String? name, image, categoryId, quantity;
  int? maxQuantity;
  num? price;
  int? cartCount;

  Product({
    required this.id,
    this.name,
    this.image,
    this.maxQuantity,
    this.quantity,
    this.price,
    this.categoryId,
    this.cartCount,
  });

  static List<Product> demoProducts = <Product>[
    Product(
      id: 'Dragon Fruit',
      image: 'assets/images/shopping_1.jpeg',
      name: 'Dragon Fruit (Red flesh) ',
      quantity: '1kg',
      price: 90,
    ),
    Product(
      id: 'Turmeric Powder',
      image: 'assets/images/shopping_2.jpeg',
      name: 'Turmeric Powder',
      quantity: '125g',
      price: 35,
    ),
    Product(
      id: 'Stingless Bee Honey',
      image: 'assets/images/shopping_3.jpeg',
      name: 'Stingless Bee Honey ',
      quantity: '100 g',
      price: 70,
    ),
    Product(
      id: 'Ginger lime Rimbucha',
      image: 'assets/images/shopping_4.jpeg',
      name: 'Ginger lime Rimbucha (Ginger & fresh lime Kombucha)',
      quantity: '200ml',
      price: 50,
    ),
    Product(
      id: 'Passion Fruit Pulp',
      image: 'assets/images/shopping_5.jpeg',
      name: 'Passion Fruit Pulp Concentrate (Purple Passion Fruit)',
      quantity: '200ml',
      price: 70,
    ),
  ];
}
