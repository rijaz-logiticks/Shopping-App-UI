import 'package:flutter/material.dart';
import 'package:shopping_ui/blocs/cart_bloc/cart_bloc.dart';

import 'package:shopping_ui/models/product.dart';

import '../config.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final CartBloc cartBloc;
  final List<Product> cartProducts;
  final int index;

  const CartItem({
    required this.product,
    required this.cartBloc,
    required this.cartProducts,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      // decoration: BoxDecoration(
      //   color: Colors.black.withOpacity(0.04),
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Container(
          //   width: 100.0,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(11.0),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(11.0),
          //     child: Center(
          //       child: FadeInImage.assetNetwork(
          //         placeholder: 'assets/icons/category_placeholder.png',
          //         image: product.image,
          //         fit: BoxFit.cover,
          //         fadeInDuration: Duration(milliseconds: 250),
          //         fadeInCurve: Curves.easeInOut,
          //         fadeOutDuration: Duration(milliseconds: 150),
          //         fadeOutCurve: Curves.easeInOut,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 0.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${index + 1}' +
                            ') ' +
                            '${product.name}' +
                            ' x '
                                '${product.quantity}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.blue.withOpacity(0.5),
                          onTap: () {
                            print('remove from cart');

                            cartBloc.add(
                              RemoveFromCartEvent(
                                productId: cartProducts[index].id,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            width: 33.0,
                            height: 30.0,
                            child: Icon(
                              Icons.delete,
                              color: Colors.black.withOpacity(0.45),
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 2.0,
                // ),
                Expanded(child: SizedBox()),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 3.0, right: 40.0, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${Config.currency}${product.price}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Material(
                              child: InkWell(
                                splashColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  int tempQuan = product.cartCount!;
                                  if (tempQuan > 1) {
                                    cartBloc.add(
                                      DecreaseQuantityEvent(
                                        productId: cartProducts[index].id,
                                      ),
                                    );
                                  }
                                  cartProducts[index].cartCount = tempQuan;
                                },
                                child: Container(
                                  width: 25.0,
                                  height: 22.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32.0,
                            height: 25.0,
                            child: Text(
                              '${product.cartCount ?? 0}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Material(
                              child: InkWell(
                                splashColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  int tempQuan = product.cartCount ?? 0;

                                  if (tempQuan <= (product.maxQuantity ?? 50)) {
                                    cartBloc.add(
                                      IncreaseQuantityEvent(
                                        productId: cartProducts[index].id,
                                      ),
                                    );

                                    cartProducts[index].cartCount = tempQuan;
                                  }
                                },
                                child: Container(
                                  width: 25.0,
                                  height: 22.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
