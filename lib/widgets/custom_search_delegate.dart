import 'package:flutter/material.dart';
import 'package:shopping_ui/models/shopping_list_data.dart';
import 'package:shopping_ui/theme/shopping_app_theme.dart';
import 'package:shopping_ui/widgets/shopping_list_view.dart';

import 'search_product_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query.length < 3)
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Center(
    //         child: Text(
    //           "Search term must be longer than two letters.",
    //         ),
    //       )
    //     ],
    //   );

    List<Product> products = Product.demoProducts
        .where((e) => (e.name!.toLowerCase().contains(query.toLowerCase())))
        .toList();

    return Container(
      color: ShoppingAppTheme.buildLightTheme().backgroundColor,
      child: ListView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return SearchProductItem(
            callback: () {},
            product: products[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> products = Product.demoProducts
        .where((e) => (e.name!.toLowerCase().contains(query.toLowerCase())))
        .toList();

    return Container(
      color: ShoppingAppTheme.buildLightTheme().backgroundColor,
      child: ListView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return SearchProductItem(
            callback: () {},
            product: products[index],
          );
        },
      ),
    );
  }
}
