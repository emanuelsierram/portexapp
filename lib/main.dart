import 'package:flutter/material.dart';
import 'package:portex_vs/screens/home_screem.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola Mundo',
        home: RecibeBook());
  }
}

class RecibeBook extends StatelessWidget {
  const RecibeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(26, 96, 143, 1),
          title: Text(
            'Portex',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs:[
           Tab(icon: Icon(Icons.home), text: 'Home',)
          ]),
        ),
      body: TabBarView(children: [HomeScreen()])),
    );
  }
}
