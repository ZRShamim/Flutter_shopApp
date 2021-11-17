import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const routName = '/orders-page';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrdersProvider>(context, listen: false)
              .fetchAndSetOrders(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (data.error != null) {
                return const Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Consumer<OrdersProvider>(
                  builder: (ctx, ordersData, child) =>ListView.builder(
                      itemCount: ordersData.orders.length,
                      itemBuilder: (ctx, i) =>
                          OrderItemList(ordersData.orders[i])),
                );
              }
            }
          },
        ));
  }
}
