import "package:flutter/material.dart";
import 'package:playground/Models/cart_notifier.dart';
import 'package:playground/Models/store_item.dart';
import 'package:playground/blogscaffold.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final storeitems = Provider.of<List<StoreItem>>(context);
    final storeitems = context.watch<List<StoreItem>>();
    return BlogScaffold(
      appbar: AppBar(
          title: Text(
            "StorePage",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, "/checkoutpage");
                }),
          ]),
      storebody: GridView.count(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        children: [for (var item in storeitems) ProductCard(item: item)],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final StoreItem item;
  const ProductCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${item.productprice} build");
    final alreadyInCart = context.select<CartNotifier, bool>((cartobj) {
      return cartobj.cartproducts.contains(item);
    });

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(item.productname),
          Image.network(item.productimageurl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + item.productprice.toString()),
              ElevatedButton(
                child: Text(
                  alreadyInCart ? "Added" : "Add to Cart",
                ),
                onPressed: alreadyInCart
                    ? null
                    : () {
                        context.read<CartNotifier>().addcartitem(item);
                      },
              ),
            ],
          )
        ])));
  }
}
