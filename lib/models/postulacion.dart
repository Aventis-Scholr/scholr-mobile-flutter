class Postulacion {
  final int id;
  final int idApoderado;
  final String status;
  final int scholarshipId;
  final Postulante postulante;
  final String? postulanteDni;
  final String? postulanteLibretaNotas;
  final String? postulanteConstLogroAprendizaje;
  final String? apoderadoDni;
  final String? apoderadoDeclaracionJurada;
  final String? reporte;

  Postulacion({
    required this.id,
    required this.idApoderado,
    required this.status,
    required this.scholarshipId,
    required this.postulante,
    this.postulanteDni,
    this.postulanteLibretaNotas,
    this.postulanteConstLogroAprendizaje,
    this.apoderadoDni,
    this.apoderadoDeclaracionJurada,
    this.reporte,
  });

  factory Postulacion.fromJson(Map<String, dynamic> json) {
    return Postulacion(
      id: (json['id'] as num).toInt(),
      idApoderado: (json['idApoderado'] as num).toInt(),
      status: json['status'],
      scholarshipId: (json['scholarshipId'] as num).toInt(),
      postulante: Postulante.fromJson(json['postulante']),
      postulanteDni: json['postulante_dni'],
      postulanteLibretaNotas: json['postulante_libreta_notas'],
      postulanteConstLogroAprendizaje: json['postulante_const_logro_aprendizaje'],
      apoderadoDni: json['apoderado_dni'],
      apoderadoDeclaracionJurada: json['apoderado_declaracion_jurada'],
      reporte: json['reporte'],
    );
  }
}

class Postulante {
  final String nombres;
  final String apellidos;
  final int dni;
  final DateTime fechaNacimiento;
  final Contacto contacto;
  final CentroEstudios centroEstudios;

  Postulante({
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.fechaNacimiento,
    required this.contacto,
    required this.centroEstudios,
  });

  factory Postulante.fromJson(Map<String, dynamic> json) {
    return Postulante(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      dni: (json['dni'] as num).toInt(),
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      contacto: Contacto.fromJson(json['contacto']),
      centroEstudios: CentroEstudios.fromJson(json['centroEstudios']),
    );
  }
}

class Contacto {
  final String correo;
  final int celular;

  Contacto({
    required this.correo,
    required this.celular,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      correo: json['correo'],
      celular: (json['celular'] as num).toInt(),
    );
  }
}

class CentroEstudios {
  final String nombre;
  final String tipo;
  final String nivel;
  final String departamento;
  final String provincia;
  final String distrito;

  CentroEstudios({
    required this.nombre,
    required this.tipo,
    required this.nivel,
    required this.departamento,
    required this.provincia,
    required this.distrito,
  });

  factory CentroEstudios.fromJson(Map<String, dynamic> json) {
    return CentroEstudios(
      nombre: json['nombre'],
      tipo: json['tipo'],
      nivel: json['nivel'],
      departamento: json['departamento'],
      provincia: json['provincia'],
      distrito: json['distrito'],
    );
  }
}
