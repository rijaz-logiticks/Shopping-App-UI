part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class AddToWishlistInProgressState extends WishlistState {
  @override
  String toString() => 'AddToWishlistInProgressState';
}

class AddToWishlistFailedState extends WishlistState {
  @override
  String toString() => 'AddToWishlistFailedState';
}

class AddToWishlistCompletedState extends WishlistState {
  @override
  String toString() => 'AddToWishlistCompletedState';
}

class RemoveFromWishlistInProgressState extends WishlistState {
  @override
  String toString() => 'RemoveFromWishlistInProgressState';
}

class RemoveFromWishlistFailedState extends WishlistState {
  @override
  String toString() => 'RemoveFromWishlistFailedState';
}

class RemoveFromWishlistCompletedState extends WishlistState {
  @override
  String toString() => 'RemoveFromWishlistCompletedState';
}

class GetWishlistProductsFailedState extends WishlistState {
  @override
  String toString() => 'GetWishlistProductsFailedState';
}

class GetWishlistProductsInProgressState extends WishlistState {
  @override
  String toString() => 'GetWishlistProductsInProgressState';
}

class GetWishlistProductsCompletedState extends WishlistState {
  final List<Product> products;

  GetWishlistProductsCompletedState(this.products);

  @override
  String toString() => 'GetWishlistProductsCompletedState';
}