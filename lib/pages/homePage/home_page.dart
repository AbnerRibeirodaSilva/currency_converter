import 'dart:math';
import 'dart:ui';

import 'package:currency_convert/main.dart';
import 'package:currency_convert/themes/app_colors.dart';
import 'package:currency_convert/widgets/input_text_widget.dart';
import 'package:currency_convert/widgets/label_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'One';
  double? dolar;
  double? euro;
  double? canadianDolar;
  final TextEditingController controllerDolar = TextEditingController();
  final TextEditingController controllerEuro = TextEditingController();
  final TextEditingController controllerReal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controllerDolar.text = dolar.toString();
    controllerEuro.text = euro.toString();
    controllerReal.text = '';
    double windowHeigth = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shadowColor: AppColors.primary,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            var data = snapshot.connectionState;
            print(data);

            if (data == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados",
                  style: TextStyle(color: Colors.black, fontSize: 25.5),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data!["results"]['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];
                canadianDolar =
                    snapshot.data!['results']['currencies']['CAD']['buy'];
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: windowHeigth * 0.33,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(160, 20),
                            bottomRight: Radius.elliptical(160, 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 48, left: 20, right: 20),
                        child: Container(
                          height: windowHeigth * 0.33,
                          width: windowWidth * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.35),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Divider(
                                  height: 30,
                                ),
                                InputTextWidget(
                                  label: "Dolar",
                                  controller: controllerDolar,
                                ),
                                Divider(
                                  height: 25,
                                ),
                                InputTextWidget(
                                  label: "Euro",
                                  controller: controllerEuro,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 275),
                        child: Center(
                          child: LabelButton(
                              buttonWidth: windowWidth * 0.50,
                              label: 'CONVERT',
                              onPressed: () {
                                print('cliclou');
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 78, left: 36),
                        child: Container(
                          color: Colors.white,
                          height: windowHeigth * 0.178,
                          width: windowWidth * 0.30,
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 20,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'One',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              Divider(
                                height: 30,
                              ),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 20,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'One',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.5),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }),
    );
  }
}
