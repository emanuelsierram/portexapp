class Trabajador{
  String nombres;
  String apellidos;
  String telefono;
  String email;
  String cedula;
  String profesion;
  String estado;
  String estadoServicio;

  Trabajador({
    required this.nombres,
    required this.apellidos,
    required this.telefono,
    required this.email,
    required this.cedula,
    required this.profesion,
    required this.estado,
    required this.estadoServicio
  });

  factory Trabajador.fromJSON(Map<String, dynamic> json){
    return Trabajador(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      telefono: json['telefono'],
      email: json['email'],
      cedula: json['cedula'],
      profesion: json['profesion'],
      estado: json['estado'],
      estadoServicio: json['estadoServicio']
  
      );
  }

  Map<String, dynamic> toJson(){

    return {
      'nombres': nombres,
      'telefono': telefono,
      'email': email,
      'cedula': cedula,
      'profesion': profesion,
      'estado': estado,
      'estadoServicio': estadoServicio
    };
  }

  @override
  String toString(){
    return 'Trabajador{nombres: $nombres, apellidos: $apellidos, telefono: $telefono}';
  }


}