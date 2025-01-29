import 'package:flutter/material.dart';


class TrabajadorDetail extends StatelessWidget {
  final String trabajadorName;
  const TrabajadorDetail({super.key, required this.trabajadorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trabajadorName),
        backgroundColor: Color.fromRGBO(26, 96, 143, 1),
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back), color: Colors.white),
      )
    );
  }
}