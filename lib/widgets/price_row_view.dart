import 'package:flutter/material.dart';

class PriceRowView extends StatelessWidget {
  final String title;
  final String price;
  final bool isHighlighted;
  const PriceRowView(
      {Key? key,
      required this.title,
      required this.price,
      this.isHighlighted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: isHighlighted
                ? Theme.of(context).primaryColor
                : Colors.black.withOpacity(0.7),
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: isHighlighted
                ? Theme.of(context).primaryColor
                : Colors.black.withOpacity(0.7),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
