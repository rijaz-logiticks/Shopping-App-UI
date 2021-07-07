import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/screens/cart_page.dart';

class CartFABButton extends StatelessWidget {
  BuildContext buildContext;

  CartFABButton(this.buildContext);
  @override
  Widget build(BuildContext context) {
    var cartBloc = BlocProvider.of<CartBloc>(context);
    return FloatingActionButton(
      elevation: 10,
      onPressed: () {
        Navigator.push(
            buildContext, MaterialPageRoute(builder: (context) => CartScreen()));
      },
      child: Container(
        width: 58.0,
        height: 58.0,
        child: BlocBuilder(
          bloc: cartBloc,
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: 55.0,
                    height: 55.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                cartBloc.cartProducts.isNotEmpty
                    ? Positioned(
                        right: 0.0,
                        top: 0.0,
                        child: Container(
                          height: 21.0,
                          width: 21.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.amber,
                          ),
                          child: Text(
                            '${cartBloc.cartProducts.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );

            return Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.shopping_cart,
                size: 25.0,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
