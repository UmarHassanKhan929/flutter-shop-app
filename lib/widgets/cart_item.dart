import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/cart.dart';

class checkoutCartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  checkoutCartItem(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('YEETING...'),
              content: Text(
                'Want to remove ${title} from cart ?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 255, 225, 136),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: FittedBox(
                child: Text('$price'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Price: \$ ${(price * quantity).round()}'),
          trailing: Container(
            child: FittedBox(
              child: Column(
                children: [
                  Text(
                    '$quantity x',
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeSingleItem(productId);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .addSingleItem(productId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
