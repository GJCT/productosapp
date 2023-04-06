import 'package:flutter/material.dart';
import 'package:productosapp/models/models.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _borderCard(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _Image(product.picture),
            _Details(product.name, product.id),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(product.price)
            ),
            if(!product.available)
            const Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _borderCard() => BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    boxShadow: const[
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 8),
        blurRadius: 15
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  
  final double price;

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.deepPurple[900],
        borderRadius: const BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 18))
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {

  final String title;
  final String subTitle;
  const _Details(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        width: double.infinity,
        height: 70,
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 5,),
            Text(subTitle, style: const TextStyle(fontSize: 18, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.deepPurple[900],
    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _Image extends StatelessWidget {

  final String url;

  const _Image(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: url == null 
        ? const Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
        )
        :FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}