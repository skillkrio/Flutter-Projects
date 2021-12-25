import 'package:flutter/foundation.dart';
import 'package:playground/Models/store_item.dart';

class CartNotifier extends ChangeNotifier {
  final List<StoreItem> _cartproducts = [
    // StoreItem(
    //     productname: "Wrist Watch",
    //     productimageurl:
    //         "https://cdn.shopify.com/s/files/1/0272/7188/8984/products/product-image-1136254028.jpg?v=1573468738",
    //     productprice: 45),
    // StoreItem(
    //     productname: "Shampoo",
    //     productimageurl:
    //         "https://www.powproductphotography.com/wp-content/uploads/2021/06/white-on-white-product-photography-11.jpg",
    //     productprice: 90),
  ];

  List<StoreItem> get cartproducts {
    return _cartproducts;
  }

  void removecartitem(StoreItem item) {
    _cartproducts.remove(item);
    notifyListeners();
  }

  void addcartitem(StoreItem item) {
    _cartproducts.add(item);
    notifyListeners();
  }

  num get total {
    return _cartproducts.fold(
        0, (previousvalue, cartitem) => previousvalue + cartitem.productprice);
  }
}



// At the same time I want to change the button name . If the user clicked the Add to Cart button. The button name should be changed to Added.