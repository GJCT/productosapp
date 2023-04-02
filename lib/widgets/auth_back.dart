import 'package:flutter/material.dart';

class AuthBack extends StatelessWidget {

  final Widget child;
  
  const AuthBack({required this.child ,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.blueAccent,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _BlueBox(),
          const _Icon(),
          child,
        ],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin_rounded, color: Colors.white, size: 100,),
      ),
    );
  }
}

class _BlueBox extends StatelessWidget {
  const _BlueBox();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _decorationBox(),
      child: Stack(
        children: const [
          Positioned(
            top: 30,
            left: 30,
            child: _Bubble(),
          ),
          Positioned(
            top: 380,
            left: 30,
            child: _Bubble(),
          ),
          Positioned(
            top: 50,
            left: 470,
            child: _Bubble(),
          ),
          Positioned(
            top: 180,
            left: 180,
            child: _Bubble(),
          ),
          Positioned(
            top: 300,
            left: 380,
            child: _Bubble(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _decorationBox() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]
    )
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}