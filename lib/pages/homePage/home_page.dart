import 'dart:ui';

import 'package:currency_convert/main.dart';
import 'package:currency_convert/themes/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    double windowHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shadowColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          Container(
            height: windowHeigth * 0.35,
            color: AppColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Container(
              height: windowHeigth * 0.35,
              width: MediaQuery.of(context).size.width * 0.90,
              color: Colors.red,
            ),
          ),
          FutureBuilder<Map>(
              future: getData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: Text(
                        "Carregando dados...",
                        style: TextStyle(color: Colors.amber, fontSize: 25.5),
                        textAlign: TextAlign.center,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        "Erro ao carregar dados",
                        style: TextStyle(color: Colors.amber, fontSize: 25.5),
                        textAlign: TextAlign.center,
                      ));
                    } else {
                      dolar =
                          snapshot.data!["results"]['currencies']['USD']['buy'];
                      euro =
                          snapshot.data!['results']['currencies']['EUR']['buy'];
                      return Container(
                        child: Center(
                          child: Text(dolar.toString()),
                        ),
                      );
                    }
                }
              }),
        ],
      ),
    );
  }
}
