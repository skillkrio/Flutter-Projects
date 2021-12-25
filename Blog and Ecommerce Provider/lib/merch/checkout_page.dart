import "package:flutter/material.dart";
import "package:playground/Models/cart_notifier.dart";
import "package:provider/provider.dart";
import 'package:playground/blogscaffold.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartNotifier>();
    return BlogScaffold(
      appbar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      storebody: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: cart.cartproducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle:
                    Text(cart.cartproducts[index].productprice.toString()),
                trailing: IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context
                        .read<CartNotifier>()
                        .removecartitem(cart.cartproducts[index]);
                  },
                ),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(cart.cartproducts[index].productimageurl),
                ),
                title: Text(
                  cart.cartproducts[index].productname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          SizedBox(
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Buy",
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 4),
                          content: Text("We are just Dummy Store"),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(context.read<CartNotifier>().total.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
