part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productId;

  AddToCartEvent({required this.productId});

  @override
  String toString() => 'AddToCartEvent';
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;

  RemoveFromCartEvent({required this.productId});

  @override
  String toString() => 'RemoveFromCartEvent';
}

class IncreaseQuantityEvent extends CartEvent {
  final String productId;

  IncreaseQuantityEvent({required this.productId});
  @override
  String toString() => 'IncreaseQuantityEvent';
}

class DecreaseQuantityEvent extends CartEvent {
  final String productId;
  DecreaseQuantityEvent({required this.productId});
  @override
  String toString() => 'DecreaseQuantityEvent';
}

class InitializeCartEvent extends CartEvent {
  @override
  String toString() => 'InitializeCartEvent';
}

class GetCartCountEvent extends CartEvent {
  final String uid;
  GetCartCountEvent(this.uid);

  @override
  String toString() => 'GetCartCountEvent';
}

class CartCountUpdateEvent extends CartEvent {
  final int cartCount;
  CartCountUpdateEvent(this.cartCount);

  @override
  String toString() => 'CartCountUpdateEvent';
}

class GetCartProductsEvent extends CartEvent {

  @override
  String toString() => 'GetCartProductsEvent';
}

class GetCartValuesEvent extends CartEvent {
  @override
  String toString() => 'GetCartValuesEvent';
}

class ClearCartEvent extends CartEvent {
 
  @override
  String toString() => 'ClearCartEvent';
}


class PlaceOrderEvent extends CartEvent {
  @override
  String toString() => 'PlaceOrderEvent';
}