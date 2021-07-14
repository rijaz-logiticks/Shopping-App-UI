import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_ui/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:shopping_ui/widgets/common/custom_app_bar.dart';
import 'package:shopping_ui/widgets/common/empty_items_view.dart';
import 'package:shopping_ui/widgets/product_item_view.dart';
import 'package:shopping_ui/widgets/shimmer_cart_item.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late WishlistBloc wishlistBloc;

  @override
  void initState() {
    super.initState();
    wishlistBloc = BlocProvider.of<WishlistBloc>(context);
    wishlistBloc.add(GetWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Wishlist',
            needBackButton: true,
          ),
          Expanded(
              child: BlocBuilder(
                  bloc: wishlistBloc,
                  builder: (context, state) {
                    if (state is GetWishlistProductsInProgressState) {
                      return ListView.separated(
                        itemCount: 5,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            period: Duration(milliseconds: 800),
                            baseColor: Colors.grey.withOpacity(0.5),
                            highlightColor: Colors.black.withOpacity(0.5),
                            child: ShimmerCartItem(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.0);
                        },
                      );
                    }
                    if (state is GetWishlistProductsFailedState) {
                      return EmptyItemsView(
                        title: 'Failed to get products in wishlist!',
                      );
                    }
                    if (state is GetWishlistProductsCompletedState) {
                      if (state.products.length == 0) {
                        return Center(
                          child: EmptyItemsView(
                            title: 'Wishlist is empty',
                          ),
                        );
                      }

                      return Container(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            ListView.separated(
                              itemCount: state.products.length,
                              padding: const EdgeInsets.all(0.0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductItemView(
                                  product: state.products[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1,
                                  //child: SizedBox( height: 10.0)
                                );
                              },
                            ),
                            SizedBox(
                              height: 90.0,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }))
        ],
      ),
    );
  }
}
