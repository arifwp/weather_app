import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/data/weather_response.dart';
import 'dart:convert';
import 'package:weather_app/data/wilayah_response.dart';

class HttpProvider with ChangeNotifier {
  Future<List<String>> getAllWilayah() async {
    final baseUrl = 'https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;

      for (var element in jsonData) {
        items.add(element["propinsi"]);
      }
      List<String> result = LinkedHashSet<String>.from(items).toList();
      return result;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> getAllCity() async {
    final baseUrl = 'https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["kota"]);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<String>> checkData(String kota) async {
    final baseUrl = 'https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json';

    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<String> cityName = [];
      List<String> items = [];
      var jsonDataCity = json.decode(response.body);
      for (var element in jsonDataCity) {
        cityName.add(element["kota"]);
      }
      if (cityName.contains(kota)) {
        print("asdasd : ${jsonDataCity}");
      }

      // var jsonData = json.decode(response.body);
      // print("cityName : ${kota}");
      // print(jsonData);
      // print("ID : ${items}");
      return items;
    } else {
      throw response.statusCode;
    }
  }

  Future<String> getWeather(String id) async {
    final baseUrl =
        'https://ibnux.github.io/BMKG-importer/cuaca/' + id + '.json';

    http.Response response = await http.get(Uri.parse(baseUrl));
    var dateNow = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(dateNow);
    print(formattedDate);

    return formattedDate;
  }

  // Future<String> getCuaca(String id) async {
  //   final baseUrl =
  //       'https://ibnux.github.io/BMKG-importer/cuaca/' + id + '.json';

  //   http.Response response = await http.get(Uri.parse(baseUrl));
  //   if (response.statusCode == 200) {
  //     print("response body : ${response.body}");

  //     Weather weather = Weather.fromJson(response.body as Map<String, dynamic>);
  //     return Weather.fromJson(jsonEncode(response.body));
  //   } else {
  //     throw response.statusCode;
  //   }
  // }
}
