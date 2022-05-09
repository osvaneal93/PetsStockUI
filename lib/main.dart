import 'package:cann_app/ui/views/catalog_view.dart';
import 'package:cann_app/ui/views/products_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute:"catalog/" ,
      routes: {
        "productSettings/":(context) => ProductsView(),
        'catalog/': (context) => CatalogView(),
      },
    );
  }
}

