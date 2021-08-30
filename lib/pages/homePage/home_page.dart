import 'dart:ui';

import 'package:currency_convert/main.dart';
import 'package:currency_convert/themes/app_colors.dart';
import 'package:currency_convert/widgets/label_button_widget.dart';
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
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shadowColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          Container(
            height: windowHeigth * 0.35,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: windowHeigth * 0.35,
              width: windowWidth * 0.9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Center(
              child: LabelButton(
                  buttonWidth: windowWidth * 0.42,
                  label: 'CLEAR',
                  onPressed: () {
                    print('cliclou');
                  }),
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
                          child: Text(''),
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
