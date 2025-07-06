class Apoderado {
  int id;
  String name;

  Apoderado({
    required this.id,
    required this.name
  });

  static Apoderado objJson(Map<String, dynamic> json) {
    return Apoderado(
    id: json["id"] as int,
    name: json["username"] as String
    );
  }
}

class DataApoderado {
  String nombres;
  String apellidos;
  int dni;
  DateTime fechaNacimiento;
  Contacto contacto;
  Domicilio domicilio;
  CuentaBancaria cuentaBancaria;
  InformacionLaboral informacionLaboral;

  DataApoderado({
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.fechaNacimiento,
    required this.contacto,
    required this.domicilio,
    required this.cuentaBancaria,
    required this.informacionLaboral,
  });

  factory DataApoderado.fromJson(Map<String, dynamic> json) {
    return DataApoderado(
      nombres: json["nombres"] as String,
      apellidos: json["apellidos"] as String,
      dni: json["dni"] as int,
      fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
      contacto: Contacto.fromJson(json["contacto"]),
      domicilio: Domicilio.fromJson(json["domicilio"]),
      cuentaBancaria: CuentaBancaria.fromJson(json["cuentaBancaria"]),
      informacionLaboral: InformacionLaboral.fromJson(json["informacionLaboral"]),
    );
  }
}

class Contacto {
  String correo;
  int celular;

  Contacto({
    required this.correo,
    required this.celular,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      correo: json["correo"],
      celular: json["celular"],
    );
  }
}

class Domicilio {
  String direccion;
  String departamento;
  String provincia;
  String distrito;

  Domicilio({
    required this.direccion,
    required this.departamento,
    required this.provincia,
    required this.distrito,
  });

  factory Domicilio.fromJson(Map<String, dynamic> json) {
    return Domicilio(
      direccion: json["direccion"],
      departamento: json["departamento"],
      provincia: json["provincia"],
      distrito: json["distrito"],
    );
  }
}

class CuentaBancaria {
  String entidadBancaria;
  int numeroCuenta;
  int cci;

  CuentaBancaria({
    required this.entidadBancaria,
    required this.numeroCuenta,
    required this.cci,
  });

  factory CuentaBancaria.fromJson(Map<String, dynamic> json) {
    return CuentaBancaria(
      entidadBancaria: json["entidadBancaria"],
      numeroCuenta: json["numeroCuenta"],
      cci: json["cci"],
    );
  }
}

class InformacionLaboral {
  String tipoColaborador;
  String cargo;
  String sede;
  String local;
  int ingreso;

  InformacionLaboral({
    required this.tipoColaborador,
    required this.cargo,
    required this.sede,
    required this.local,
    required this.ingreso,
  });

  factory InformacionLaboral.fromJson(Map<String, dynamic> json) {
    return InformacionLaboral(
      tipoColaborador: json["tipoColaborador"],
      cargo: json["cargo"],
      sede: json["sede"],
      local: json["local"],
      ingreso: json["ingreso"],
    );
  }
}
