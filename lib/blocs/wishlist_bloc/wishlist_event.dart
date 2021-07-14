part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class AddToWishListEvent extends WishlistEvent {
  final String productId;

  AddToWishListEvent({required this.productId});

  @override
  String toString() => 'AddToWishListEvent';
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final String productId;

  RemoveFromWishlistEvent({required this.productId});

  @override
  String toString() => 'RemoveFromWishlistEvent';
}

class GetWishlistEvent extends WishlistEvent {


  @override
  String toString() => 'GetWishlistEvent';
}