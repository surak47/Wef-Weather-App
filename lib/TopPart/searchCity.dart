// ignore_for_file: use_key_in_widget_constructors, file_names, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wefweatherapp/ListofCities';

class SearchCity extends StatefulWidget {
  Function(String cityName, String countryCode, String countryName)
      updateToSelectedCity;
  SearchCity({required this.updateToSelectedCity});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  List<Map<String, String>> results = Cities;

  void searchWithFilter(String value) {
    if (value.isEmpty) {
      results = Cities;
    } else {
      results = [];
      results = Cities.where((element) => element['city']
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase())).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.01),
                Colors.white.withOpacity(0.1)
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    onChanged: (value) {
                      searchWithFilter(value);
                      setState(() {});
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.026),
                    decoration: InputDecoration(
                      prefixText: "  ",
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: MediaQuery.of(context).size.height * 0.026),
                      hintText: "Search City",
                      suffixIcon: const Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return Card(
                      key: ValueKey(results[index]['city']),
                      color: const Color.fromARGB(255, 45, 56, 137),
                      elevation: 10,
                      margin: const EdgeInsets.all(6),
                      child: GestureDetector(
                        onTap: () {
                          widget.updateToSelectedCity(
                              results[index]['city']!,
                              results[index]['code']!,
                              results[index]['country']!);
                          Navigator.of(context).pop();
                        },
                        child: ListTile(
                          iconColor: Colors.white,
                          leading: const Icon(Icons.location_on),
                          title: Text(results[index]['city']!,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(results[index]['country']!,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5))),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
