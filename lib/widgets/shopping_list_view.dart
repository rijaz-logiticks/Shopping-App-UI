import 'package:flutter/material.dart';
import 'package:shopping_ui/models/product.dart';
import 'package:shopping_ui/widgets/product_item_view.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView(
      {Key? key,
      required this.product,
      required this.animationController,
      required this.animation,
      required this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Product product;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: ProductItemView(
              product: product,
            ),
          ),
        );
      },
    );
  }
}
