import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_ui/blocs/wishlist_bloc/wishlist_bloc.dart';

import 'app.dart';
import 'blocs/cart_bloc/cart_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CartBloc(),
      ),
      BlocProvider(
        create: (context) => WishlistBloc(),
      ),
    ],
    child: ShoppingApp(),
  ));
}
