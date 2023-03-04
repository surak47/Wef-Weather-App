// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:convert';
import 'package:wefweatherapp/BottomPart/bottomPart.dart';
import 'package:wefweatherapp/ListofCities';
import 'package:flutter/material.dart';
import 'TopPart/topPart.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BackBoard extends StatefulWidget {
  @override
  State<BackBoard> createState() => _BackBoardState();
}

class _BackBoardState extends State<BackBoard> {
  @override
  void initState() {
    super.initState();
    location = Cities[0]['city']!;
    countryName = "Ethiopia";
    countryCode = "ET";
    setVariablesWeatherData(location);
  }

  //------------variables used to show data on the top half of the screen
  double temp = 00;
  String desc = "Pull to Refresh!";
  String dayFormated = "No Data";
  double wind = 00;
  double humidity = 00;
  double rain = 00;
  String location = "";
  String countryCode = "";
  String countryName = "";
  bool isDay = true;
  bool isSun = true;

  //-----------Variables used to show on the bottom part of the screen
  double temp1 = 0.0, temp2 = 0.0, temp3 = 0.0, temp4 = 0.0;
  String time1 = "00:00", time2 = "00:00", time3 = "00:00", time4 = "00:00";

  //returns JSON data from openweathermap for a specfied city
  Future<dynamic> getWeatherData(String cityName) async {
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&cnt=5&appid=0c1943c27245bdeb33c0706fba22362e";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Server isn't in the mood");
    }
  }

  //-----sets all the variables there corsponding value from the JSON data feteched
  void setVariablesWeatherData(String cityName) async {
    try {
      Map<String, dynamic> jsonData = await getWeatherData(cityName);

      //------Setting Top Part Data----------------------------//
      temp = jsonData['list'][0]['main']['temp'] * 1.0;
      desc = jsonData['list'][0]['weather'][0]['description'];
      dayFormated = DateFormat('EEEE, MMM d')
          .format(DateTime.parse(jsonData['list'][0]['dt_txt']));
      wind = jsonData['list'][0]['wind']['speed'] * 3.6;
      humidity = (jsonData['list'][0]['main']['humidity'] as int) * 1.0;
      rain = jsonData['list'][0]['pop'] * 100.0;

      //-----Getting Current Location Time
      final timezoneOffset = jsonData['city']['timezone'];
      final now = DateTime.now();
      int currLocationTime;
      if (now.timeZoneOffset.inSeconds == timezoneOffset) {
        //if ur viewing the city you are in
        currLocationTime = now.hour;
      } else {
        currLocationTime = now.add(Duration(seconds: timezoneOffset)).hour;
      }
      //  print("Current Local time is $currLocationTime");
      if (currLocationTime > 6 && currLocationTime < 19) {
        isDay = true; //day
      } else {
        isDay = false;
      }

      if (temp > 15) {
        isSun = true;
      } else {
        isSun = false;
      }
      setState(() {});

      //-------Setting Bottom Part Data-------------------//
      DateTime dateTime;
      temp1 = jsonData['list'][1]['main']['temp'] * 1.0;
      dateTime = DateTime.parse(jsonData['list'][1]['dt_txt']);
      time1 =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      temp2 = jsonData['list'][2]['main']['temp'] * 1.0;
      dateTime = DateTime.parse(jsonData['list'][2]['dt_txt']);
      time2 =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      temp3 = jsonData['list'][3]['main']['temp'] * 1.0;
      dateTime = DateTime.parse(jsonData['list'][3]['dt_txt']);
      time3 =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      temp4 = jsonData['list'][4]['main']['temp'] * 1.0;
      dateTime = DateTime.parse(jsonData['list'][4]['dt_txt']);
      time4 =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      // print(
      //     "Temp: $temp, Desc: $desc, Date: $dayFormated, wind :$wind, Humididy:$humidity, Rain: $rain, ");
    } catch (err) {
      temp = 00;
      desc = "Pull to Refresh!";
      dayFormated = "No Data";
      wind = 00;
      humidity = 00;
      rain = 00;
      countryCode = "";
      countryName = "";
      isDay = true;
      isSun = true;
      //print("Failed bc: $err");
    }
  }

  //---based on location selected, it updates the entire widgets used to show the widget selected
  void updateToSelectedCity(
      String cityName, String countryCode, String countryName) {
    location = cityName;
    this.countryCode = countryCode;
    this.countryName = countryName;
    setVariablesWeatherData(location);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(255, 5, 8, 26),
      child: Column(
        children: [
          TopPart(
              dayFormated: dayFormated,
              desc: desc,
              humidity: humidity.toInt(),
              rain: rain.toInt(),
              temp: temp,
              wind: wind.toInt(),
              isDay: isDay,
              isSun: isSun,
              location: location,
              updateToSelectedCity: updateToSelectedCity,
              countryCode: countryCode,
              countryName: countryName),
          BottomPart(
            temp1: temp1,
            temp2: temp2,
            temp3: temp3,
            temp4: temp4,
            time1: time1,
            time2: time2,
            time3: time3,
            time4: time4,
            isDay: isDay,
          ),
        ],
      ),
    );
  }
}
