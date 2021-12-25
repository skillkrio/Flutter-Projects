import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playground/Models/cart_notifier.dart';
import "package:playground/blog_post.dart";
import "package:playground/homepage.dart";
import 'package:playground/merch/checkout_page.dart';
import 'package:playground/merch/storepage.dart';
import 'package:playground/testing.dart';
import 'package:playground/user.dart';
import "package:provider/provider.dart";

import 'Models/store_item.dart';
import 'Models/testmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

var themeData = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      height: 1.4,
      color: Colors.black,
    ),
    caption: TextStyle(height: 1.4, fontSize: 18),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
            create: (context) => FirebaseAuth.instance.authStateChanges(),
            initialData: null),
        StreamProvider<List<BlogPost>>(
            create: (context) => getblogposts(), initialData: []),
        ProxyProvider<User?, BlogUser>(
          create: (context) => BlogUser(
              profileurl:
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              profiletitle: "Flutter Blo",
              isloggedin: false),
          update: (context, firebaseuser, bloguser) {
            return BlogUser(
                profileurl: bloguser!.profileurl,
                profiletitle: bloguser.profiletitle,
                isloggedin: firebaseuser != null);
          },
        ),
        Provider<List<StoreItem>>(
          create: (context) => products,
        ),
        ChangeNotifierProvider<CartNotifier>(
            create: (context) => CartNotifier()),
        // ChangeNotifierProvider<TestModel>(create: (context) => TestModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Blog",
        theme: themeData,
        home: Homepage(),
        routes: {
          "/storepage": (context) => StorePage(),
          "/checkoutpage": (context) => CheckoutPage(),
          // "/testing": (context) => Testing(),
        },
      ),
    );
  }
}

// Future<List<BlogPost>> getblogposts() async {
//   return FirebaseFirestore.instance.collection("blogposts").get().then((query) {
//     return query.docs.map((doc) => BlogPost.frommap(doc.data())).toList();
//   });
// }

// Future<List<BlogPost>> getblogposts() async {
//   final snapshotlist = await FirebaseFirestore.instance.collection("blogposts").get();
//   return snapshotlist.docs.map((doc) => BlogPost.frommap(doc.data())).toList();
// }

// Stream<List<BlogPost>> getblogposts() {
//   final snapshots =
//       FirebaseFirestore.instance.collection("blogposts").snapshots();
//   return snapshots.map((snapshot) =>
//       snapshot.docs.map((doc) => BlogPost.frommap(doc.data())).toList()
//         ..sort((first, last) {
//           return -first.publisheddate.compareTo(last.publisheddate);
//         }));
// }

Stream<List<BlogPost>> getblogposts() {
  final snapshots =
      FirebaseFirestore.instance.collection("blogposts").snapshots();
  return snapshots.map((snapshot) =>
      snapshot.docs.map((doc) => BlogPost.frommap(doc.data(), doc.id)).toList()
        ..sort((first, last) {
          return -first.publisheddate.compareTo(last.publisheddate);
        }));
}

List<StoreItem> products = [
  StoreItem(
      productname: "Wrist Watch",
      productimageurl:
          "https://cdn.shopify.com/s/files/1/0272/7188/8984/products/product-image-1136254028.jpg?v=1573468738",
      productprice: 45),
  StoreItem(
      productname: "Coffee Mug",
      productimageurl:
          "https://media.istockphoto.com/vectors/realistic-white-cup-vector-id482347987?k=20&m=482347987&s=612x612&w=0&h=U3p8yiEW-IGlQXGIYSVQ7jq4vmtvU0_85LJYu7xFcNE=",
      productprice: 20),
  StoreItem(
      productname: "Red Wine",
      productimageurl:
          "https://www.photomarketingwizard.com/wp-content/uploads/2018/02/ecommerce-product-photography-23.jpg",
      productprice: 70),
  StoreItem(
      productname: "Shampoo",
      productimageurl:
          "https://www.powproductphotography.com/wp-content/uploads/2021/06/white-on-white-product-photography-11.jpg",
      productprice: 90),
];
