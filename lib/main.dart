import 'package:currency_convert/pages/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=1d031459';

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
