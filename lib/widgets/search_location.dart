import 'package:flutter/material.dart';
import 'package:zenfemina_v2/widgets/city_data.dart';
import 'package:zenfemina_v2/navigation/dashboard.dart';

Widget buildLocationSearch(
  String selectedCity,
  List<String> cities,
  Function(String) onSelectCity,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
      color: Colors.white,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: DropdownButton<String>(
      value: selectedCity,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      dropdownColor: Colors.white,
      onChanged: (String? newValue) {
        onSelectCity(newValue!);
      },
      items: cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
