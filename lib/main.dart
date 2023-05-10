import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/http_provider.dart';
import 'package:weather_app/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: ChangeNotifierProvider(
        create: (context) => HttpProvider(),
        child: HomePage(),
      ),
    ),
  );
}
