import 'package:flutter/material.dart';
import 'package:productosapp/models/models.dart';
import 'package:productosapp/screens/screens.dart';
import 'package:productosapp/services/services.dart';
import 'package:productosapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productServices = Provider.of<ProductServices>(context);
    final authServices = Provider.of<AuthServices>(context, listen: false);

    if(productServices.loading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            onPressed: () {
              authServices.logout();
              Navigator.pushReplacementNamed(context, 'login');
            }, 
            icon: const Icon(Icons.logout)
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productServices.products.length,
        itemBuilder: ( _, int index) => GestureDetector(
          child: ProductCard(
            product: productServices.products[index],
          ),
          onTap: () {
            productServices.selectedProduct = productServices.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        ) 
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 30,),
        onPressed: () {
          productServices.selectedProduct = Product(
            available: false, 
            name: '', 
            price: 0
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}