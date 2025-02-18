import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portex_vs/models/trabajador_model.dart';
import 'package:http/http.dart' as http; 

class TrabajadorProvider extends ChangeNotifier {

  bool isLoading = false;
  List<Trabajador> trabajadores = [];
  List<Trabajador> favoriteTrabajador = [];

  //Petición a la API
  Future<void> FetchTrabajador() async{

    isLoading=true;
   WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

   final url=Uri.parse('http://10.0.2.2:8080/trabajadores');
      // final url=Uri.parse('http://localhost:8080/trabajadores');
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        String decodedResponse = utf8.decode(response.bodyBytes);
        final data= jsonDecode(decodedResponse);
        trabajadores = List<Trabajador>.from(data.
        map((trabajador)=> Trabajador.fromJSON(trabajador)));
      } else{
        print('Error ${response.statusCode}');
        trabajadores= [];
      }
    }catch (e){
      print('Error in request');
      trabajadores= [];
    }finally{
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
   
  }

  Future<void> toggleFavoriteStatus(Trabajador trabajador) async {
    final isFavorite = favoriteTrabajador.contains(trabajador);
    try {
       final url=Uri.parse('http://10.0.2.2:8080/trabajadores');
       final response = isFavorite 
       ? await http.delete(url, body: json.encode({"id": trabajador.id}))
       : await http.post(url, body: json.encode(trabajador.toJson()));
       if(response.statusCode == 200){
        if(isFavorite){
          favoriteTrabajador.remove(trabajador);
        }else{
          favoriteTrabajador.add(trabajador);
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
       } else {
        throw Exception('Failed to update Favorite Trabajador');
       }
    } catch (e) {
      print('Error Update Status Favorite Trabajador');
    }
  }

}