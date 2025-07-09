import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scholrflutter/bloc/ScholarshipsBloc.dart';
import 'package:scholrflutter/components/CustomAppBar.dart';
import 'package:scholrflutter/models/scholarship.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> list = <String>['','TOTAL', 'PARTIAL'];

class ScholarshipsHome extends StatefulWidget {
  const ScholarshipsHome({super.key});

  @override
  State<ScholarshipsHome> createState() => _ScholarshipsHomeState();
}

class _ScholarshipsHomeState extends State<ScholarshipsHome> {
  final ScholarshipsBloc scholarshipsBloc = ScholarshipsBloc();
  final TextEditingController searchTxt = TextEditingController();
  String type = list.first;
  Timer? _searchDebounce;

  // Your original color definitions
  final Color primaryBrown = const Color(0xFF765532);
  final Color lightBrown = const Color(0xFF9B7B5B);
  final Color darkBrown = const Color(0xFF523A23);
  final Color backgroundColor = const Color(0xFFDCF1F9);
  final Color textPrimaryColor = const Color(0xFF2D1810);
  final Color textSecondaryColor = const Color(0xFF5C4332);
  final Color deepBlue = const Color(0xFF2A3D66);

  @override
  void initState() {
    super.initState();
    scholarshipsBloc.add(ScholarshipsInitialFetchEvent());
    searchTxt.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchTxt.removeListener(_onSearchChanged);
    _searchDebounce?.cancel();
    searchTxt.dispose();
    scholarshipsBloc.close();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchDebounce?.isActive ?? false) _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      scholarshipsBloc.add(ScholarshipsSearchEvent(searchTxt.text));
    });
  }

  void _onTypeFilterChanged(String? value) {
    setState(() {
      type = value ?? '';
    });
    scholarshipsBloc.add(ScholarshipsFilterByTypeEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Bandeja'),
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15.0),
          Text(
            'Becas de la empresa',
            style: TextStyle(
              fontSize: 30.0,
              color: textPrimaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 230.0,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Búsqueda',
                      labelStyle: TextStyle(color: textSecondaryColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBrown, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkBrown, width: 1.5),
                      ),
                    ),
                    style: TextStyle(color: textPrimaryColor),
                    controller: searchTxt,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 110.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: darkBrown, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: DropdownButton<String>(
                      value: type.isEmpty ? null : type,
                      style: TextStyle(color: deepBlue),
                      dropdownColor: backgroundColor,
                      icon: Icon(Icons.arrow_drop_down, color: darkBrown),
                      hint: Text(
                        'Tipo',
                        style: TextStyle(color: textSecondaryColor),
                      ),
                      onChanged: _onTypeFilterChanged,
                      items: list.where((item) => item.isNotEmpty).map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: textPrimaryColor),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: BlocBuilder<ScholarshipsBloc, ScholarshipsState>(
              bloc: scholarshipsBloc,
              builder: (context, state) {
                if (state is ScholarshipsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryBrown,
                    ),
                  );
                } else if (state is ScholarshipsErrorState) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: TextStyle(color: textPrimaryColor),
                    ),
                  );
                } else if (state is ScholarshipsFetchingSuccessfulState) {
                  if (state.scholarships.isEmpty) {
                    return Center(
                      child: Text(
                        "No hay becas disponibles.",
                        style: TextStyle(color: textPrimaryColor),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.scholarships.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20.0,
                        ),
                        child: ScholarshipTile(
                          scholarship: state.scholarships[index],
                          primaryBrown: primaryBrown,
                          backgroundColor: backgroundColor,
                          textPrimaryColor: textPrimaryColor,
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryBrown,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScholarshipTile extends StatelessWidget {
  final Scholarship scholarship;
  final Color primaryBrown;
  final Color backgroundColor;
  final Color textPrimaryColor;

  const ScholarshipTile({
    super.key,
    required this.scholarship,
    required this.primaryBrown,
    required this.backgroundColor,
    required this.textPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/scholarshipdetails",
          arguments: scholarship,
        );
      },
      child: Container(
        height: 150.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFf4c542), // Your original yellow color
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // White section with scholarship name
            Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: primaryBrown,
                    width: 1.5,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                scholarship.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Yellow section with type and status
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tipo: ${scholarship.scholarshipType}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Estado: ${scholarship.scholarshipStatus}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

