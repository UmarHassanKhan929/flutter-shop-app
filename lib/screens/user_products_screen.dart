import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false)
            .fetchAndSetProducts(true),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return Provider.of<Products>(context, listen: false)
                          .fetchAndSetProducts(true);
                    },
                    child: Consumer<Products>(
                      builder: (context, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: productsData.items.length == 0
                            ? Center(
                                child: Text(
                                    "You currently dont have any of your own products, start by adding new by clicking + icon above",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )
                            : ListView.builder(
                                itemCount: productsData.items.length,
                                itemBuilder: (context, i) => Column(
                                  children: [
                                    UserProductItem(
                                      productsData.items[i].id,
                                      productsData.items[i].title,
                                      productsData.items[i].imageUrl,
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
