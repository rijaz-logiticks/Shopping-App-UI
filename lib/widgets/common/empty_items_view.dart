import 'package:flutter/material.dart';

class EmptyItemsView extends StatelessWidget {
  final String title;

  const EmptyItemsView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
