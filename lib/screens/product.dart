import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productosapp/providers/providers.dart';
import 'package:productosapp/services/services.dart';
import 'package:productosapp/ui/decoration.dart';
import 'package:productosapp/widgets/img.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productServices = Provider.of<ProductServices>(context);

    return ChangeNotifierProvider(
      create: ( _) => ProductFormProvider(productServices.selectedProduct),
      child: _ProductBody(productServices: productServices),
    );
    //return _ProductBody(productServices: productServices);
  }
}

class _ProductBody extends StatelessWidget {
  const _ProductBody({
    required this.productServices,
  });

  final ProductServices productServices;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImg(url: productServices.selectedProduct.picture,),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, 'home'), 
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,)
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 40,
                  child: IconButton(
                    onPressed: () async{
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100
                        );
                        if(pickedFile == null){
                          print('No selecciono nada');
                          return;
                        }

                        print('Abemus image: ${pickedFile.path}');

                        productServices.updateSelectedImg(pickedFile.path);
                    }, 
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                  ),
                ),
              ],
            ),
            const _FormInfo(),
            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: productServices.save ? null : () async{
          if(!productForm.validForm()) return;
          final String? imageUrl = await productServices.uploadImg();
          if(imageUrl != null) productForm.product.picture = imageUrl;
          await productServices.saveProduct(productForm.product);
          Navigator.pushNamed(context, 'home');
        },
        child: productServices.save 
        ? const CircularProgressIndicator(color: Colors.white,) 
        : const Icon(Icons.save_alt_sharp, size: 30)
      ),
    );
  }
}

class _FormInfo extends StatelessWidget {

  const _FormInfo();

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _infoForm(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'El nombre es obligatorio';
                  return null;
                },
                decoration: InputDecorations.authInput(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre:',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null){
                     product.price = 0;
                  } else{
                     product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInput(
                  hintText: '\$50',
                  labelText: 'Precio:',
                ),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.available,
                title: const Text('Disponible', style: TextStyle(fontSize: 20),),
                activeColor: Colors.deepPurple[900],
                onChanged: productForm.updateAvailability
              ),
              const SizedBox(height: 30)
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _infoForm() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 8),
        blurRadius: 5
      )
    ]
  );
}