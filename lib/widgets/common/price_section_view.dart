import 'package:flutter/material.dart';
import 'package:shopping_ui/models/charge.dart';

import '../../config.dart';
import '../price_row_view.dart';

class PriceSectionView extends StatelessWidget {
  final String? sectionTitle;
  final Charge charge;
  const PriceSectionView({Key? key, this.sectionTitle, required this.charge})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _titleWidget,
          PriceRowView(
            title: 'Order:',
            price: '${Config.currency}${charge.orderAmt.toStringAsFixed(2)}',
          ),
          SizedBox(
            height: 10.0,
          ),
          PriceRowView(
            title: 'Service Fee:',
            price: '${Config.currency}${charge.serviceFee.toStringAsFixed(2)}',
          ),
          SizedBox(
            height: 10.0,
          ),
          PriceRowView(
            title: 'Delivery Fee:',
            price: '${Config.currency}${charge.deliveryFee.toStringAsFixed(2)}',
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Total:',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.85),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                '${Config.currency}${charge.totalAmt.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.85),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _titleWidget {
    return sectionTitle != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionTitle!,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(),
              SizedBox(
                height: 5.0,
              ),
            ],
          )
        : Container();
  }
}
