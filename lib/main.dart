import 'package:cann_app/ui/views/catalog_view.dart';
import 'package:cann_app/ui/views/products_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    );
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: "catalog/",
      routes: {
        "productSettings/": (context) => ProductsView(),
        'catalog/': (context) => CatalogView(),
      },
    );
  }
}
