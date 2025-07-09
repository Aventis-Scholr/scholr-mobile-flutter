import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/DataApoderadoBloc.dart';
import '../components/CustomAppBar.dart';
import 'RechazoAllScreen.dart';

class CollaboratorInfoScreen extends StatelessWidget {
  final int dataApoderadoId;

  const CollaboratorInfoScreen({super.key, required this.dataApoderadoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataApoderadoBloc()..add(DataApoderadoInitialFetchEvent(dataApoderadoId)),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: CustomAppBar(titleText: 'Colaborador'),
        body: BlocBuilder<DataApoderadoBloc, DataApoderadoState>(
          builder: (context, state) {
            if (state is DataApoderadoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DataApoderadoFetchingSuccessfulState) {
              final apoderado = state.dataApoderado;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITULO PRINCIPAL
                    Center(
                      child: Text(
                        "Datos de ${apoderado.nombres} ${apoderado.apellidos}",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // CAMPOS DE LECTURA
                    readonlyField("Nombres", apoderado.nombres),
                    readonlyField("Apellidos", apoderado.apellidos),
                    readonlyField("DNI", apoderado.dni.toString()),
                    readonlyField("Fecha de Nacimiento", apoderado.fechaNacimiento.toString()),

                    sectionSubtitle("Contacto"),
                    readonlyField("Correo", apoderado.contacto.correo),
                    readonlyField("Celular", apoderado.contacto.celular.toString()),

                    sectionSubtitle("Abono"),
                    readonlyField("Entidad Bancaria", apoderado.cuentaBancaria.entidadBancaria),
                    readonlyField("Número de Cuenta", apoderado.cuentaBancaria.numeroCuenta.toString()),
                    readonlyField("CCI", apoderado.cuentaBancaria.cci.toString()),

                    sectionSubtitle("Domicilio"),
                    readonlyField("Dirección", apoderado.domicilio.direccion),
                    readonlyField("Departamento", apoderado.domicilio.departamento),
                    readonlyField("Provincia", apoderado.domicilio.provincia),
                    readonlyField("Distrito", apoderado.domicilio.distrito),

                    sectionSubtitle("Información Laboral"),
                    readonlyField("Tipo de colaborador", apoderado.informacionLaboral.tipoColaborador),
                    readonlyField("Cargo", apoderado.informacionLaboral.cargo),
                    readonlyField("Sede", apoderado.informacionLaboral.sede),
                    readonlyField("Local", apoderado.informacionLaboral.local),
                    readonlyField("Ingreso", apoderado.informacionLaboral.ingreso.toString()),

                    /*sectionSubtitle("Archivos Adjuntos"),
                    ...apoderado.archivos.map(downloadField).toList(),*/

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Acción para descargar todo
                        },
                        icon: const Icon(Icons.download, color: Colors.black),
                        label: const Text(
                          "Descargar todo",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text("Aceptar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A3D66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/postulantlist",
                                arguments: {
                                  'apoderadoId': dataApoderadoId,
                                  'apoderadoName': apoderado.nombres,
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.close, color: Colors.white),
                            label: const Text("Rechazar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A3D66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RechazoAllScreen(apoderadoId: dataApoderadoId),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            } else if (state is DataApoderadoFetchingErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("Estado desconocido."));
            }
          },
        ),
      ),
    );
  }

  Widget readonlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color(0xFFE0E0E0),
        ),
      ),
    );
  }

  Widget sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget downloadField(String fileName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(fileName, style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: () {
              // Acción de descarga
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }
}
