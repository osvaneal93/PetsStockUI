import 'package:cann_app/data/models/product_model.dart';
import 'package:cann_app/ui/providers/products_provider.dart';
import 'package:flutter/material.dart';

class CatalogView extends StatefulWidget {
  CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  final provider = ProductsProvider();

  final product = ProductModel();

  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return Scaffold(
      body: FutureBuilder(
        future: provider.getProduct(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) =>
                _listBuilder(context, snapshot.data![index]),
            itemCount: snapshot.data!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'productSettings/', arguments: product);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _listBuilder(context, ProductModel productModel) {
    return Dismissible(
      onDismissed: (direction) => provider.deleteProduct(productModel.id!),
      key: UniqueKey(),
      child: ListTile(
        title: Text(productModel.name!),
        subtitle: Text(productModel.id!),
        onTap: () {
          Navigator.pushNamed(context, 'productSettings/',
              arguments: productModel);
        },
      ),
    );
  }
}
