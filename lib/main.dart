import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/cart_page.dart';
import './pages/edit_product_page.dart';
import './pages/orders_page.dart';
import './pages/product_detail_page.dart';
import './pages/products_overview_page.dart';
import './pages/user_product_page.dart';
import './providers/cart_provider.dart';
import './providers/order_provider.dart';
import './providers/product_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato',
            textTheme:
                const TextTheme(headline1: TextStyle(color: Colors.white))),
        home: ProductOverviewpage(),
        routes: {
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
          OrdersPage.routName: (ctx) => OrdersPage(),
          UserProductPage.routeName: (ctx) => UserProductPage(),
          EditProductPage.routeName: (ctx) => EditProductPage()
        },
      ),
    );
  }
}
