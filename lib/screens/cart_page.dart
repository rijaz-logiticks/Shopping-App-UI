import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_ui/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/config.dart';
import 'package:shopping_ui/models/charge.dart';
import 'package:shopping_ui/models/product.dart';
import 'package:shopping_ui/screens/checkout_page.dart';
import 'package:shopping_ui/widgets/cart_item.dart';
import 'package:shopping_ui/widgets/common/custom_app_bar.dart';
import 'package:shopping_ui/widgets/common/empty_items_view.dart';
import 'package:shopping_ui/widgets/common/price_section_view.dart';
import 'package:shopping_ui/widgets/shimmer_cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartBloc cartBloc;
  List<Product> cartProducts = [];

  TextEditingController couponController = TextEditingController();

  double totalAmt = 0, orderAmt = 0;
  @override
  void initState() {
    super.initState();

    cartBloc = BlocProvider.of<CartBloc>(context);

    cartBloc.add(GetCartProductsEvent());
  }

  calculateAmount() {
    totalAmt = 0;
    orderAmt = 0;

    for (var product in cartProducts) {
      orderAmt = orderAmt + (product.price! * product.cartCount!);
    }

    totalAmt = orderAmt + Config.deliveryFee + Config.serviceFee;
  }

  void showRemovingProductDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Removing the product',
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              CustomAppBar(
                title: "My Cart",
                leading: BlocBuilder(
                  bloc: cartBloc,
                  builder: (context, state) {
                    if (state is GetCartProductsInProgressState) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 12.0),
                        child: Text(
                          'Items: --',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      );
                    }
                    if (state is GetCartProductsCompletedState) {
                      cartProducts = state.cartProductsList;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 12.0),
                        child: Text(
                          'Items: ${state.cartProductsList.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 12.0),
                      child: Text(
                        'Items: --',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder(
                  bloc: cartBloc,
                  builder: (context, state) {
                    if (state is GetCartProductsInProgressState) {
                      return ListView.separated(
                        itemCount: 5,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            period: Duration(milliseconds: 800),
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.black.withOpacity(0.5),
                            child: ShimmerCartItem(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.0);
                        },
                      );
                    }
                    if (state is GetCartProductsFailedState) {
                      return EmptyItemsView(
                        title: 'Failed to get products in cart!',
                      );
                    }
                    if (state is GetCartProductsCompletedState ||
                        state is IncreaseQuantityInProgressState ||
                        state is IncreaseQuantityCompletedState ||
                        state is RemoveFromCartCompletedState) {
                      if (state is GetCartProductsCompletedState) {
                        cartProducts = state.cartProductsList;
                      }
                      if (cartProducts.length == 0) {
                        return Center(
                          child: EmptyItemsView(
                            title: 'Cart is empty',
                          ),
                        );
                      }
                      calculateAmount();

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            ListView.separated(
                              itemCount: cartProducts.length,
                              padding: const EdgeInsets.all(0.0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CartItem(
                                  cartProducts: cartProducts,
                                  index: index,
                                  product: cartProducts[index],
                                  cartBloc: cartBloc,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1,
                                  margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  color: Colors.black.withOpacity(0.2),
                                  //child: SizedBox( height: 10.0)
                                );
                              },
                            ),
                            // Container(
                            //   height: 1,
                            //   margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            //   color: Colors.black.withOpacity(0.2),
                            // ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              children: [
                                PriceSectionView(
                                  sectionTitle: 'Charges',
                                  charge: Charge(
                                    serviceFee: Config.serviceFee,
                                    deliveryFee: Config.deliveryFee,
                                    totalAmt: totalAmt,
                                    orderAmt: orderAmt,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 90.0,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
          BlocBuilder(
            bloc: cartBloc,
            builder: (context, state) {
              if (state is GetCartProductsCompletedState) {
                if (state.cartProductsList.length > 0) {
                  return Positioned(
                    bottom: MediaQuery.of(context).padding.bottom,
                    child: Container(
                      height: 80.0,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white70,
                            Colors.white54,
                            Colors.white10,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                cartProducts: cartProducts,
                                charge: Charge(
                                  serviceFee: Config.serviceFee,
                                  deliveryFee: Config.deliveryFee,
                                  totalAmt: totalAmt,
                                  orderAmt: orderAmt,
                                ),
                              ),
                            ),
                          );
                        },
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'CHECKOUT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
