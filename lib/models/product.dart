class Product {
  String id;
  String? name, image, quantity, description;
  int? maxQuantity;
  num? price;
  int? cartCount;

  Product(
      {required this.id,
      this.name,
      this.image,
      this.maxQuantity,
      this.quantity,
      this.price,
      this.cartCount,
      this.description});

  static List<Product> demoProducts = <Product>[
    Product(
        id: 'Dragon Fruit',
        image: 'assets/images/shopping_1.jpeg',
        name: 'Dragon Fruit (Red flesh) ',
        quantity: '1kg',
        price: 90,
        description:
            '''Dragon fruit grows on the Hylocereus cactus, also known as the Honolulu queen, whose flowers only open at night. 
        The plant is native to southern Mexico and Central America. Today, it is grown all over the world. It goes by many names, including pitaya, pitahaya, and strawberry pear. 
        The two most common types have bright red skin with green scales that resemble a dragon — hence the name. The most widely available variety has white pulp with black seeds, though a less common type with red pulp and black seeds exists as well. Another variety — referred to as yellow dragon fruit — has yellow skin and white pulp with black seeds. 
        Dragon fruit may look exotic, but its taste has been described as a slightly sweet cross between a kiwi and a pear.'''),
    Product(
        id: 'Turmeric Powder',
        image: 'assets/images/shopping_2.jpeg',
        name: 'Turmeric Powder',
        quantity: '125g',
        price: 35,
        description:
            '''Turmeric — and especially its most active compound, curcumin — have many scientifically proven health benefits, such as the potential to improve heart health and prevent against Alzheimer's and cancer. 
      It's a potent anti-inflammatory and antioxidant. It may also help improve symptoms of depression and arthritis.'''),
    Product(
        id: 'Stingless Bee Honey',
        image: 'assets/images/shopping_3.jpeg',
        name: 'Stingless Bee Honey ',
        quantity: '100 g',
        price: 70,
        description:
            '''Stingless bee honey can be used as an antibacterial ingredient in pharmaceutical formulations since it possesses antimicrobial and antiseptic properties.'''),
    Product(
        id: 'Ginger lime Rimbucha',
        image: 'assets/images/shopping_4.jpeg',
        name: 'Ginger lime Rimbucha (Ginger & fresh lime Kombucha)',
        quantity: '200ml',
        price: 50,
        description:
            '''GingerLime, an invigorating and caffeine-free buch, pairs an all-gingerbrew and its own unique live cultures with bright, fresh,cold-pressed lime and an extra helping of cold-pressed ginger.'''),
    Product(
        id: 'Passion Fruit Pulp',
        image: 'assets/images/shopping_5.jpeg',
        name: 'Passion Fruit Pulp Concentrate (Purple Passion Fruit)',
        quantity: '200ml',
        price: 70,
        description:
            '''Passion fruit, sometimes called maracuya, is exotically colored -- purple, yellow and even orange -- and has a hollow center filled with seeds.
       Each seed is surrounded by a juice-filled pulp, and it is this that gives the fruit its flavor -- tart with an underlying sweetness -- and is used to make passion fruit puree.'''),
  ];
}
