class Product {
  String? id, name, image, categoryId,quantity;
  int? maxQuantity ;
  num? price;

  Product({
    this.id,
    this.name,
    this.image,
    this.maxQuantity,
    this.quantity,
    this.price,
    this.categoryId,
  });

  static List<Product> demoProducts = <Product>[
    Product(
      image: 'assets/images/shopping_1.jpeg',
      name: 'Dragon Fruit (Red flesh) ',
      quantity: '1kg',
      price: 180,
    ),
    Product(
      image: 'assets/images/shopping_2.jpeg',
      name: 'Turmeric Powder',
      quantity: '125g',
      price: 180,
    ),
    Product(
      image: 'assets/images/shopping_3.jpeg',
      name: 'Stingless Bee Honey ',
      quantity: '100 g',
      price: 180,
    ),
    Product(
      image: 'assets/images/shopping_4.jpeg',
      name: 'Ginger lime Rimbucha (Ginger & fresh lime Kombucha)',
      quantity: '200ml',
      price: 180,
    ),
    Product(
      image: 'assets/images/shopping_5.jpeg',
      name: 'Passion Fruit Pulp Concentrate (Purple Passion Fruit)',
      quantity: '200ml',
      price: 180,
    ),
  ];
}
