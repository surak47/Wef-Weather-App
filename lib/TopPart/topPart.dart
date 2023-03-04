// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, unnecessary_this

import 'package:flutter/material.dart';
import 'cloudLottie.dart';
import 'tempAndDate.dart';
import 'topBar.dart';

class TopPart extends StatelessWidget {
  Function(String cityName, String countryCode, String countryName)
      updateToSelectedCity;
  double temp;
  String desc;
  String dayFormated;
  int wind;
  int humidity;
  int rain;
  String location;
  bool isDay;
  bool isSun;
  String countryCode;
  String countryName;
  TopPart(
      {required this.temp,
      required this.desc,
      required this.dayFormated,
      required this.wind,
      required this.humidity,
      required this.rain,
      required this.location,
      required this.isDay,
      required this.isSun,
      required this.updateToSelectedCity,
      required this.countryCode,
      required this.countryName});

  double scrW = 0, scrH = 0;
  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: isDay
            ? const LinearGradient(colors: [
                Color.fromARGB(255, 149, 185, 240),
                Color.fromARGB(255, 59, 53, 173)
              ], begin: Alignment.topCenter, end: Alignment.bottomLeft)
            : const LinearGradient(colors: [
                Color.fromARGB(255, 29, 44, 66),
                Color.fromARGB(255, 17, 16, 49)
              ], begin: Alignment.topCenter, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(45),
      ),
      width: scrW * 0.95,
      height: scrH * 0.75,
      child: RefreshIndicator(
        onRefresh: () async {
          updateToSelectedCity(
              this.location, this.countryCode, this.countryName);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox.fromSize(
            child: Column(
              children: [
                TopBar(
                  location: location,
                  updateToSelectedCity: updateToSelectedCity,
                  countryCode: countryCode,
                  countryName: countryName,
                ),
                CloudLottie(isDay: isDay, isSun: isSun),
                TempAndDate(
                    dayFormated: dayFormated,
                    desc: desc,
                    humidity: humidity,
                    rain: rain,
                    temp: temp,
                    wind: wind),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
