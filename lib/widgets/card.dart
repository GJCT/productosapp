import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {

  final Widget child;

  const CardContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _createCard(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCard() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const[
      BoxShadow(
        color: Colors.black26,
        blurRadius: 20,
        offset: Offset(0, 5)
      )
    ]
  );
}