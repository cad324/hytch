import 'package:flutter/material.dart';

AppBar DefaultAppBar(String title, {Builder? leading}) {
  return AppBar(
    centerTitle: false,
    title: Text(title),
    backgroundColor: Colors.white,
    leading: leading,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromARGB(255, 132, 37, 205),
              Color.fromARGB(255, 178, 65, 196)
            ]),
      ),
    ),
    elevation: 10,
  );
}
