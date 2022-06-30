import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/order_item.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  var _isLoading = false;
  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnap) {
              if (dataSnap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnap.error != null) {
                  return Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) =>
                          AllOrderItems(orderData.orders[i]),
                    ),
                  );
                }
              }
            }));
  }
}

        //  _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: orderData.length,
        //         itemBuilder: (ctx, i) => AllOrderItems(orderData[i]),
        //       ),
//         );
//   }
// }
