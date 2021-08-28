// @dart=2.9
import 'package:sensors/sensors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platos',
      debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String nom_plato = "";
  bool izq = true, der = true;
  List platos = [
    "assets/images/arroz_quezo.jpg",
    "assets/images/charquekan.jpg",
    "assets/images/chicharon.jpg",
    "assets/images/falso_conejo.png",
    "assets/images/fritanga.png",
    "assets/images/majadito.png",
    "assets/images/picana.png",
    "assets/images/pique_macho.jpg",
    "assets/images/plato_paceno.png",
    "assets/images/ranga.png",
    "assets/images/sajta.png",
    "assets/images/salchipapa.png",
    "assets/images/silpancho.png",
    "assets/images/sopa_mani.png",
    "assets/images/thimpu.jpg",
  ];
  List nomPlatos = [
    "Arroz con quezo",
    "Charquekan",
    "Chicharon",
    "Falso conejo",
    "Fritanga",
    "Majadito",
    "Picana",
    "Pique macho",
    "Plato paceno",
    "Ranga",
    "Sajta",
    "Salchipapa",
    "Silpancho",
    "Sopa_mani",
    "Thimpu",
  ];
  bool switch_sensor = true;
  double x = 0, y = 0, z = 0;
  Random random = new Random();
  void initState() {
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    }); //get the sensor data and set then to the data types
  }

  int puntero = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurante"),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Platos tipicos",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            Text(
              nomPlatos[puntero],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            image_dishes(puntero),
            Container(
              height: 50,
              child: Row(
                //scrollDirection: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(
                      child: Icon(
                        Icons.arrow_left,
                        size: 20,
                      ),
                      onPressed: izq ? _izquierda : null),
                  RaisedButton(
                    child: Text(
                      "VOY A TENER SUERTE",
                      style: TextStyle(fontSize: 11),
                    ),
                    onPressed: () {
                      setState(() {
                        int random1 = random.nextInt(15);
                        print(random1.toString());
                        puntero = random1;
                        if (puntero == 0) {
                          izq = false;
                          der = true;
                        }
                        if (puntero == platos.length - 1) {
                          der = false;
                          izq = true;
                        }
                        if (puntero > 0 && puntero < platos.length - 2) {
                          izq = true;
                          der = true;
                        }
                      });
                    },
                  ),
                  RaisedButton(
                      child: Icon(
                        Icons.arrow_right,
                        size: 20,
                      ),
                      onPressed: der ? _derecha : null),
                ],
              ),
            ),
            Table(
              border: TableBorder.all(
                  width: 2.0,
                  color: Colors.blueAccent,
                  style: BorderStyle.solid),
              children: [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "eje mov X : ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      movimiento_x(x),
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ])
              ],
            )
          ],
        ),
      ),
    );
  }

  String movimiento_x(double x) {
    setState(() {});
    String mov = "";
    print("valor x: ");
    print(x.toStringAsFixed(0));
    int move = int.parse(x.toStringAsFixed(0));
    if (x < -2) {
      if (der) {
        mov = "derecha";
        _derecha();
      } else {}
    }
    if (x > 2) {
      if (izq) {
        mov = "izquierda";
        _izquierda();
      } else {}
    }
    if (x < 2 && x > -2) {
      mov = "quieto";
    }
    if (x < -5.95 || x > 5.95) {
      mov = "brusco";

      if (switch_sensor) {}
    }
    return mov + "(" + move.toString() + ")";
  }

  void _derecha() {
    String mov = "";
    puntero = puntero + 1;
    if (puntero == 14) {
      der = false;
    }
    if (puntero == 1) {
      print(platos.length);
      izq = true;
    }
  }

  void _izquierda() {
    String mov = "";
    setState(() {
      puntero = puntero - 1;
      if (puntero == 0) {
        print(platos.length);
        izq = false;
        der = true;
      }
      if (puntero == 13) {
        der = true;
      }
    });
  }

  Container image_dishes(int puntero) {
    String imagen = platos[puntero];
    return Container(
      width: 150,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(150)),
        //color: Colors.red,
        image: DecorationImage(
            scale: 10, fit: BoxFit.fill, image: AssetImage(imagen)),
        //shape: BoxShape.circle,
      ),

      // ...
    );
  }
}
