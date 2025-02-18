
import 'package:flutter/material.dart';
import 'package:portex_vs/models/trabajador_model.dart';
import 'package:portex_vs/providers/trabajador_provider.dart';
import 'package:portex_vs/screens/trabajador_detail.dart';
import 'package:provider/provider.dart';

class FavoriteScreem extends StatelessWidget {
  const FavoriteScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TrabajadorProvider>(
        builder: (context, trabajadorProvider, child){
        final favoriteTrabajador = trabajadorProvider.favoriteTrabajador;
        return favoriteTrabajador.isEmpty ? Center(child: Text("No hay Trabajadores favoritos"),)
        : ListView.builder(
          itemCount: favoriteTrabajador.length,
          itemBuilder: (context, index){
            final trabajador = favoriteTrabajador[index];
            return FavoriteTrabajadorCard(trabajador: trabajador); 
          }); 
        },
      )
    );
  }
}


class FavoriteTrabajadorCard extends StatelessWidget {
  final Trabajador trabajador;
  const FavoriteTrabajadorCard({super.key, required this.trabajador});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TrabajadorDetail(trabajadorData: trabajador)));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(trabajador.nombres),
            Text(trabajador.profesion)
          ]
        )
      )
    );
  }
}