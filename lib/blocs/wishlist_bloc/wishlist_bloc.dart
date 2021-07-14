import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_ui/models/product.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial());
  List<Product> wishlist = [];

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is AddToWishListEvent) {
      yield* mapAddToWishlistEventToState(event.productId);
    }
    if (event is RemoveFromWishlistEvent) {
      yield* mapRemoveFromWishlistEventToState(
        event.productId,
      );
    }

    if (event is GetWishlistEvent) {
      yield* mapGetWishlistEventToState();
    }
  }

  Stream<WishlistState> mapAddToWishlistEventToState(String productId) async* {
    yield AddToWishlistInProgressState();
    try {
      //add to cart

      Product product = Product.demoProducts.firstWhere(
        (element) => element.id == productId,
      );

      wishlist.add(product);

      add(GetWishlistEvent());
      yield AddToWishlistCompletedState();
    } catch (e) {
      print('Error: $e');
      yield AddToWishlistFailedState();
    }
  }

  Stream<WishlistState> mapRemoveFromWishlistEventToState(
    String productId,
  ) async* {
    yield RemoveFromWishlistInProgressState();
    try {
      wishlist.removeWhere(
        (element) => element.id == productId,
      );

      add(GetWishlistEvent());
      yield RemoveFromWishlistCompletedState();
    } catch (e) {
      print('Error: $e');
      yield RemoveFromWishlistFailedState();
    }
  }

  Stream<WishlistState> mapGetWishlistEventToState() async* {
    yield GetWishlistProductsInProgressState();
    try {
      if (wishlist != null) {
        await Future.delayed(Duration(milliseconds: 150));
        yield GetWishlistProductsCompletedState(wishlist);
      } else {
        yield GetWishlistProductsFailedState();
      }
    } catch (e) {
      print(e);
      yield GetWishlistProductsFailedState();
    }
  }
}
