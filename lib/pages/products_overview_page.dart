import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOption { Favorites, All }

class ProductOverviewpage extends StatefulWidget {
  @override
  State<ProductOverviewpage> createState() => _ProductOverviewpageState();
}

class _ProductOverviewpageState extends State<ProductOverviewpage> {
  var _showOnlyFavoriteData = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProduct();
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProduct();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProduct().then((_) {
        setState(() {
        _isLoading = false;
      });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (FilterOption selectedValues) {
                setState(() {
                  if (selectedValues == FilterOption.Favorites) {
                    _showOnlyFavoriteData = true;
                  } else {
                    _showOnlyFavoriteData = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOption.Favorites,
                    ),
                    const PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOption.All,
                    )
                  ]),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartPage.routeName),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading? const Center(
        child: CircularProgressIndicator(),
      ) : ProductGrid(_showOnlyFavoriteData),
    );
  }
}
