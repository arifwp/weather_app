import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/weather_response.dart';
import 'package:weather_app/models/http_provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/wilayah_response.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropdownvalue;
  String? dropdownCityValue;
  late Future<List<Wilayah>> futureWilayah;
  Future<List<Weather>>? futureWeather;
  int defaultCelcius = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xff2095f3), Color(0xff8fcaf9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        FutureBuilder<List<String>>(
                          future: HttpProvider().getAllWilayah(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return DropdownButton(
                                key: UniqueKey(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                underline: SizedBox(),
                                hint: Text(
                                  'Pilih Provinsi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: dropdownvalue,
                                items: data.map((items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownvalue = newValue;
                                    defaultCelcius = 30;
                                  });
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        FutureBuilder<List<String>>(
                          future: HttpProvider().getAllCity(),
                          builder: (context, snapshot) {
                            if (dropdownvalue == null) {
                              // var dataCity = snapshot.data!;
                              return Text(
                                'Pilih Kota',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else if (dropdownvalue != null) {
                              List<String> dataCity = snapshot.data!;
                              return DropdownButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                underline: SizedBox(),
                                hint: Text(
                                  'Pilih Kota',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: dropdownCityValue,
                                items: dataCity.map((items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownCityValue = newValue;
                                    defaultCelcius = 12;
                                  });
                                },
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              defaultCelcius.toString(),
                              style: TextStyle(
                                fontSize: 140,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                'o',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Minggu, 7 Mei 02.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Hujan Sedang',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Image.asset(
                          'assets/images/4.png',
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 20,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 120,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '00:00',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Image.asset(
                                        'assets/images/rainy.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '27',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'o',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                Container(
                                  width: 120,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '02:00',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Image.asset(
                                        'assets/images/storm.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '22',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'o',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                Container(
                                  width: 120,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '06:00',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Image.asset(
                                        'assets/images/cloudy.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '30',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'o',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                Container(
                                  width: 120,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '09:00',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Image.asset(
                                          'assets/images/cloudy.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '32',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'o',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
