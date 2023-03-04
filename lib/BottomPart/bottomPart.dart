// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BottomPart extends StatelessWidget {
  double scrW = 0, scrH = 0;
  double temp1, temp2, temp3, temp4;
  String time1, time2, time3, time4;
  bool isDay;
  BottomPart({
    required this.temp1,
    required this.temp2,
    required this.temp3,
    required this.temp4,
    required this.time1,
    required this.time2,
    required this.time3,
    required this.time4,
    required this.isDay,
  });
  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return SizedBox(
      width: scrW * 0.95,
      height: scrH * 0.20,
      child: Column(
        children: [
          SizedBox(
            height: scrH * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomCards(temp: temp1, time: time1, isDay: isDay),
              BottomCards(temp: temp2, time: time2, isDay: isDay),
              BottomCards(temp: temp3, time: time3, isDay: isDay),
              BottomCards(temp: temp4, time: time4, isDay: isDay),
            ],
          ),
        ],
      ),
    );
  }
}

//---------------------------------------------------------

class BottomCards extends StatefulWidget {
  double temp;
  String time;
  bool isDay;
  BottomCards({required this.temp, required this.time, required this.isDay});
  @override
  State<BottomCards> createState() => _BottomCardsState();
}

class _BottomCardsState extends State<BottomCards> {
  double scrW = 0, scrH = 0;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    scrW = MediaQuery.of(context).size.width;
    scrH = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? (widget.isDay
                  ? Colors.blue
                  : const Color.fromARGB(255, 19, 48, 72))
              : Colors.transparent,
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                      color: Colors.blue,
                      blurRadius: 13,
                      blurStyle: BlurStyle.normal)
                ]
              : [const BoxShadow()],
        ),
        width: scrW * 0.20,
        height: scrH * 0.15,
        child: Column(
          children: [
            SizedBox(
              height: scrH * 0.01,
            ),
            Text(
              ("${widget.temp.toStringAsFixed(1)}°"),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: scrH * 0.03,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
                widget.temp > 15
                    ? Icons.wb_sunny_outlined
                    : Icons.cloudy_snowing,
                color: Colors.white,
                size: scrH * 0.06),
            SizedBox(height: scrH * 0.01),
            Text(
              widget.time,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: scrW * 0.032,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
