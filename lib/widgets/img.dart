import 'dart:io';

import 'package:flutter/material.dart';

class ProductImg extends StatelessWidget {
  
  final String? url;

  const ProductImg({this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _decorationBox(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.6,
          child: ClipRRect(
            borderRadius: const BorderRadius.only( topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(url)
          ),
        ),
      ),
    
    );
  }

  BoxDecoration _decorationBox() => const BoxDecoration(
    borderRadius: BorderRadius.only( topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 8)
      )
    ]
  );

  Widget getImage(String? picture) {
    if(picture == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'), 
        fit: BoxFit.cover
      );
    }
    

    if(picture.startsWith('http')){
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
