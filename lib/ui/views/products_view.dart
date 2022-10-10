import 'dart:io';

import 'package:cann_app/core/utils/validators.dart' as validators;
import 'package:cann_app/data/models/product_model.dart';
import 'package:cann_app/ui/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_core/firebase_core.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);
  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final formKey = GlobalKey<FormState>();
  final snackbarKey = GlobalKey<ScaffoldState>();
  final productModel = ProductModel();
  final productProvider = ProductsProvider();
  bool saving = false;
  XFile? imageP;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final productParameter =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetsApp'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          GestureDetector(
            child: IconButton(
              onPressed: () {
                _addImage(productParameter);
              },
              icon: const Icon(Icons.image),
            ),
          ),
          GestureDetector(
            child: IconButton(
              onPressed: () {
                _takePhoto();
              },
              icon: const Icon(Icons.camera),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: sizeScreen.height * .09,
              ),
              _showImage(sizeScreen, productParameter),
              SizedBox(
                height: sizeScreen.height * .04,
              ),
              const Text('Product Name:'),
              _addProduct(context, productParameter),
              const SizedBox(
                height: 10,
              ),
              const Text('Price:'),
              _addPrice(context, productParameter),
              _switchStock(),
              _buttonSave(productParameter),
            ],
          ),
        ),
      ),
    );
  }

  _takePhoto() async {
    imageP = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {});
  }

  _addImage(ProductModel productPro) async {
    imageP = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (imageP != null) {
      productPro.fotoUrl = null;
    }
    setState(() {});
  }

  _showImage(Size size, ProductModel productPro) {
    if (productPro.fotoUrl != null) {
      return Image.network(productPro.fotoUrl!);
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: imageP != null
            ? Image.file(
                File(imageP!.path),
                height: size.height * .4,
                width: size.width * .9,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/noImage.png',
                height: size.height * .4,
                fit: BoxFit.cover,
              ),
      );
    }
  }

  Future uploadFile() async {
    if (imageP == null) return;
    await Firebase.initializeApp();
    final fileName = imageP!.path;
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(imageP! as File);
    } catch (e) {
      print('error occured');
    }
  }

  Container _addProduct(BuildContext context, ProductModel parameter) {
    final sizeDevice = MediaQuery.of(context).size;
    return Container(
      height: sizeDevice.height * .07,
      width: sizeDevice.width * .9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.brown.shade300,
        borderRadius: BorderRadius.circular(35),
      ),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: (parameter.name == null) ? '' : parameter.name,
        onSaved: (value) {
          productModel.name = value;
        },
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.length <= 3) {
            return 'Mas de 3 caracteres';
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
      ),
    );
  }

  Container _addPrice(BuildContext context, ProductModel parameter) {
    final sizeDevice = MediaQuery.of(context).size;
    return Container(
      height: sizeDevice.height * .07,
      width: sizeDevice.width * .9,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.brown.shade300,
        borderRadius: BorderRadius.circular(35),
      ),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: (parameter.value == 0) ? '' : parameter.value.toString(),
        onSaved: (value) {
          productModel.value = int.parse(value!);
        },
        validator: (value) {
          if (!validators.validatorForm(value)) return 'solo numeros';
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
      ),
    );
  }

  _switchStock() {
    return Center(
      child: SwitchListTile(
        value: productModel.disponible!,
        title: Text('En Stock'),
        onChanged: (value) {
          setState(() {
            productModel.disponible = value;
          });
        },
      ),
    );
  }

  _buttonSave(ProductModel productParameter) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
    return OutlinedButton.icon(
      icon: const Icon(Icons.save),
      label: const Text('Save'),
      style: raisedButtonStyle,
      onPressed: (saving)
          ? null
          : () async {
              _submit(productParameter);

              final String? imageUrl =
                  await productProvider.uploadImage(imageP!);
              if (imageUrl != null) {
                productParameter.fotoUrl = imageUrl;
              }
            },
    );
  }

  void _submit(ProductModel productParameter) async {
    if (!formKey.currentState!.validate()) return;
    putSnackbar();
    formKey.currentState!.save();

    setState(() {
      saving = true;
    });

    if (imageP != null) {
      productModel.fotoUrl = await productProvider.uploadImage(imageP!);
    }
    if (productParameter.id == null) {
      productProvider.addProduct(productModel);
    } else {
      productProvider.updateProduct(productModel, productParameter.id!);
    }

    setState(() {
      saving = false;
    });

    Navigator.pop(context);
  }

  putSnackbar() {
    final snackbar = const SnackBar(content: Text('Producto Guardado'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
