import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scholrflutter/components/CustomAppBar.dart';
import 'package:scholrflutter/models/scholarship.dart';

const List<String> list = <String>['','TOTAL', 'PARCIAL'];

class ScholarshipsHome extends StatefulWidget {
  const ScholarshipsHome({super.key});

  @override
  State<ScholarshipsHome> createState() => _ScholarshipsHomeState();
}

class _ScholarshipsHomeState extends State<ScholarshipsHome> {

  // Colores personalizados
  final Color primaryBrown = const Color(0xFF765532);
  final Color lightBrown = const Color(0xFF9B7B5B);
  final Color darkBrown = const Color(0xFF523A23);
  final Color backgroundColor = const Color(0xFFDCF1F9);
  final Color textPrimaryColor = const Color(0xFF2D1810);
  final Color textSecondaryColor = const Color(0xFF5C4332);
  final Color deepBlue = const Color(0xFF2A3D66);

  final searchTxt = TextEditingController();
  String type = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Bandeja'),
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15.0),
          Text(
              'Becas de la empresa',
              style: TextStyle(
                fontSize: 30.0
              )
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230.0,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Búsqueda',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    controller: searchTxt,
                  )
                ),
                SizedBox(width: 10),
                Container(
                    width: 110.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: DropdownButton(
                            value: type,
                            style: TextStyle(
                                color: deepBlue,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                type = value!;
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(value: value, child: Text(value));
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          ScholarshipTile(scholarship: Scholarship())
        ],
      ),
    );
  }
}

class ScholarshipTile extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarshipTile({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: Color(0xFFf4c542),
        border: Border.all(
          color: Colors.black,
          width: 1.5
        )
      ),
      child: Column(
        children: [
          Container(
            width: 300,
            height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.black,
                    width: 1.5
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
