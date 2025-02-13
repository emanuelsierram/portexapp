import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portex_vs/screens/trabajador_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//Petición a la API
  Future<List<dynamic>> FetchRecipes() async{
    
   final url=Uri.parse('http://10.0.2.2:8080/trabajadores');
      // final url=Uri.parse('http://localhost:8080/trabajadores');


    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final data= jsonDecode(response.body);
        return data;
      } else{
        print('Error ${response.statusCode}');
        return [];
      }
    }catch (e){
      print('Error in request');
      return [];
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(future: FetchRecipes(), 
      builder: (context, snapshot){
        final trabajadores = snapshot.data ?? [];
        //Estados de carga
        if(snapshot.connectionState== ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No found'));
        }
        else{
        return ListView.builder(
          itemCount: trabajadores.length, 
          itemBuilder: (context, index){
          return _PortexCard(context, trabajadores[index]);
        });
      }
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(26, 96, 143, 1),
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            _showBotton(context);
          }),
    );
  }

  /*Future<void> _showBotton(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (contexto) => Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              color: Colors.white,
              child: const PortexForm(),
            ));
  }
*/
  Future<void> _showBotton(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (contexto) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(contexto).viewInsets.bottom,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 600,
        color: Colors.white,
        child: const PortexForm(),
      ),
    ),
  );
}


  Widget _PortexCard(BuildContext context, dynamic trabajador) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TrabajadorDetail(trabajadorName: trabajador['nombres'])));

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                        'https://forteinnovation.mx/revista/wp-content/uploads/2022/05/364146-PB1OW0-666.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trabajador['nombres'],
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 1,
                      width: 75,
                      color: const Color.fromRGBO(26, 96, 143, 1),
                    ),
                    Text(
                     trabajador['profesion'],
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(
                      height: 4,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PortexForm extends StatelessWidget {
  const PortexForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeLastName = TextEditingController();
    final TextEditingController _recipeImg = TextEditingController();
    final TextEditingController _recipeJob = TextEditingController();

    return Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new jobs',
                style: TextStyle(
                    color: Color.fromRGBO(26, 96, 143, 1), fontSize: 24),
              ),
              SizedBox(
                height: 16,
              ),
              _buildTextfield(
                  controller: _recipeName,
                  label: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Name';
                    }
                    return null;
                  }),
              SizedBox(
                height: 16,
              ),
              _buildTextfield(
                  controller: _recipeLastName,
                  label: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Last name';
                    }
                    return null;
                  }),
              SizedBox(
                height: 16,
              ),
              _buildTextfield(
                  controller: _recipeImg,
                  label: 'Image Url',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Image Url';
                    }
                    return null;
                  }),
              SizedBox(
                height: 16,
              ),
              _buildTextfield(
                  maxLines: 4,
                  controller: _recipeJob,
                  label: 'Job',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Job';
                    }
                    return null;
                  }),
              SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(26, 96, 143, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ));
  }

  Widget _buildTextfield(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?) validator,
      int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontFamily: 'Quicksand',
              color: Color.fromRGBO(26, 96, 143, 1),
              fontSize: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(26, 96, 143, 1)),
              borderRadius: BorderRadius.circular(10))),
      validator: validator,
      maxLines: maxLines,
    );
  }
}
