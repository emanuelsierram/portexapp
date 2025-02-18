import 'package:flutter/material.dart';
import 'package:portex_vs/models/trabajador_model.dart';
import 'package:portex_vs/providers/trabajador_provider.dart';
import 'package:provider/provider.dart';

class TrabajadorDetail extends StatefulWidget {
  final Trabajador trabajadorData;

  const TrabajadorDetail({super.key, required this.trabajadorData});

  @override
  _TrabajadorDetailState createState() => _TrabajadorDetailState();
}

class _TrabajadorDetailState extends State<TrabajadorDetail> {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<TrabajadorProvider>(context, listen: false)
        .favoriteTrabajador
        .contains(widget.trabajadorData);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.trabajadorData.nombres, style: TextStyle(color: Colors.white),),
      backgroundColor: Color.fromRGBO(26, 96, 143, 1),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white),
      actions: [
        IconButton(onPressed: () async{
          await Provider.of<TrabajadorProvider>(context, listen: false).toggleFavoriteStatus(widget.trabajadorData);
          setState(() {
            isFavorite = !isFavorite;
          });
        }, 
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border))
      ],    
    ),
    body: Padding(padding: EdgeInsets.all(18),
    child: Column(children: [
      Image.network('https://forteinnovation.mx/revista/wp-content/uploads/2022/05/364146-PB1OW0-666.jpg'),
      SizedBox(height: 8,),
      Text(widget.trabajadorData.nombres),
      SizedBox(height: 8,),
      Text(widget.trabajadorData.profesion)
    ],),),
    );
  }
}


