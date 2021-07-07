import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_ui/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  CartState get initialState => CartInitial();

  List<Product> cartProducts = [];

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCartEvent) {
      yield* mapAddToCartEventToState(event.productId);
    }
    if (event is RemoveFromCartEvent) {
      yield* mapRemoveFromCartEventToState(
        event.productId,
      );
    }

    if (event is GetCartProductsEvent) {
      yield* mapGetCartProductsEventToState();
    }
    if (event is IncreaseQuantityEvent) {
      yield* mapIncreaseQuantityEventToState(
        productId: event.productId,
      );
    }
    if (event is DecreaseQuantityEvent) {
      yield* mapDecreaseQuantityEventToState(
        productId: event.productId,
      );
    }
    if (event is PlaceOrderEvent) {
      yield* mapPlaceOrderEventToState();
    }
  }

  Stream<CartState> mapAddToCartEventToState(String productId) async* {
    yield AddToCartInProgressState();
    try {
      //add to cart

      Product product = Product.demoProducts.firstWhere(
        (element) => element.id == productId,
      );

      bool alreadyExists = cartProducts.contains(product);

      if (!alreadyExists) {
        product.cartCount = 1;

        cartProducts.add(product);
      } else {
        product.cartCount = product.cartCount! + 1;
      }

      add(GetCartProductsEvent());
      yield AddToCartCompletedState();
    } catch (e) {
      print('Error: $e');
      yield AddToCartFailedState();
    }
  }

  Stream<CartState> mapRemoveFromCartEventToState(
    String productId,
  ) async* {
    yield RemoveFromCartInProgressState();
    try {
      Product product = cartProducts.firstWhere(
        (element) => element.id == productId,
      );
      bool alreadyExists = cartProducts.contains(product);

      if (alreadyExists) {
        cartProducts.remove(product);
      }
      add(GetCartProductsEvent());
      yield RemoveFromCartCompletedState();
    } catch (e) {
      print('Error: $e');
      yield RemoveFromCartFailedState();
    }
  }

  Stream<CartState> mapGetCartProductsEventToState() async* {
    yield GetCartProductsInProgressState();
    try {
      if (cartProducts != null) {
        await Future.delayed(Duration(milliseconds: 150));
        yield GetCartProductsCompletedState(cartProducts);
      } else {
        yield GetCartProductsFailedState();
      }
    } catch (e) {
      print(e);
      yield GetCartProductsFailedState();
    }
  }

  Stream<CartState> mapIncreaseQuantityEventToState({
    required String productId,
  }) async* {
    yield IncreaseQuantityInProgressState();
    try {
      Product product = cartProducts.firstWhere(
        (element) => element.id == productId,
      );

      if (product.cartCount == null)
        product.cartCount = 1;
      else
        product.cartCount = product.cartCount! + 1;

      add(GetCartProductsEvent());
      yield IncreaseQuantityCompletedState();
    } catch (e) {
      print(e);
      yield IncreaseQuantityFailedState();
    }
  }

  Stream<CartState> mapDecreaseQuantityEventToState({
    required String productId,
  }) async* {
    yield DecreaseQuantityInProgressState();
    try {
      Product product = cartProducts.firstWhere(
        (element) => element.id == productId,
      );

      if (product.cartCount == null)
        product.cartCount = 0;
      else
        product.cartCount = product.cartCount! - 1;
      add(GetCartProductsEvent());
      yield DecreaseQuantityCompletedState();
    } catch (e) {
      print(e);
      yield DecreaseQuantityFailedState();
    }
  }

  Stream<CartState> mapPlaceOrderEventToState() async* {
    yield PlaceOrderInProgressState();
    try {
      await Future.delayed(Duration(seconds: 5));
      cartProducts.clear();
      yield GetCartProductsCompletedState([]);
      yield PlaceOrderCompletedState();
    } catch (e) {
      print(e);
      yield PlaceOrderFailedState();
    }
  }
}
