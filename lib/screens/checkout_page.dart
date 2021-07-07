import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/blocs/cart_bloc/cart_bloc.dart';
import 'package:shopping_ui/models/charge.dart';
import 'package:shopping_ui/models/product.dart';
import 'package:shopping_ui/widgets/common/custom_app_bar.dart';
import 'package:shopping_ui/widgets/common/price_section_view.dart';
import 'package:shopping_ui/widgets/order_placed_dialog.dart';
import 'package:shopping_ui/widgets/place_order_dialog.dart';
import 'package:shopping_ui/widgets/processing_dialog.dart';
import 'package:shopping_ui/widgets/utils.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartProducts;

  Charge charge;

  CheckoutScreen({
    required this.cartProducts,
    required this.charge,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? selectedPayment;

  late TextEditingController instructionsController;
  late CartBloc cartBloc;
  @override
  void initState() {
    super.initState();

    instructionsController = TextEditingController();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.stream.listen((state) {
      if (state is PlaceOrderInProgressState) {
        showPlacingOrderDialog();
      }
      if (state is PlaceOrderCompletedState) {
        Navigator.pop(context);
        showOrderPlaceDialog();
      }
    });
  }

  showPlacingOrderDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PlaceOrderDialog();
      },
    );
  }

  showOrderPlaceDialog() async {
    var res = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return OrderPlacedDialog();
      },
    );

    if (res == 'PLACED') {
      //placed
      Navigator.popUntil(context, (route) => route.isFirst);

      return;
    }
  }

  showProcessingDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ProcessingDialog(
          message: 'Please wait!\nWe are processing order...',
        );
      },
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
                title: 'Checkout',
                needBackButton: true,
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0.0),
                            blurRadius: 15.0,
                            spreadRadius: 2.0,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              'Select a payment method',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          RadioListTile(
                            activeColor: Theme.of(context).primaryColor,
                            dense: true,
                            value: 1,
                            groupValue: selectedPayment,
                            title: Text(
                              'Cash on delivery',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                            onChanged: (int? val) {
                              setState(() {
                                selectedPayment = val;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Theme.of(context).primaryColor,
                            dense: true,
                            value: 2,
                            groupValue: selectedPayment,
                            title: Text(
                              'Pay via Credit/Debit card',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                            onChanged: (int? val) {
                              setState(() {
                                selectedPayment = val;
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Theme.of(context).primaryColor,
                            dense: true,
                            value: 3,
                            groupValue: selectedPayment,
                            title: Text(
                              'Pay via Razorpay',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                            ),
                            onChanged: (int? val) {
                              setState(() {
                                selectedPayment = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PriceSectionView(
                      charge: widget.charge,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Instructions:  ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: instructionsController,
                        onChanged: (val) {
                          if (val.trim().length > 0) {}
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        enableInteractiveSelection: false,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          border: InputBorder.none,
                          hintText: 'eg: Call me before delivery',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            child: Container(
              height: 80.0,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                  if (selectedPayment == null) {
                    showSnack('Select a payment method', context,
                        bgColor: Colors.red);
                    return;
                  }
                  cartBloc.add(PlaceOrderEvent());
                },
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  'CONFIRM & PROCEED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
