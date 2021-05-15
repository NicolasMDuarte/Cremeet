import 'package:empresa_app/screens/criar_evento.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 200,
                ),
                Container(
                  child: Text("Cremeet",
                      style: GoogleFonts.lato(
                          fontSize: 40, fontStyle: FontStyle.italic)),
                  margin: EdgeInsets.only(top: 0, bottom: 60),
                )
              ],
            ),
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 40),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  'Eventos',
                  style: GoogleFonts.lato(),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CriarEvento())),
                          child: Text("Criar")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CriarEvento())),
                          child: Text("Editar")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CriarEvento())),
                        child: Text("Excluir"),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
