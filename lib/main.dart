import 'package:flutter/material.dart';

void main() {
  runApp(const CachoTableroApp());
}

class CachoTableroApp extends StatelessWidget {
  const CachoTableroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SeleccionCantidadScreen(),
    );
  }
}

// Primera pantalla para seleccionar cantidad de tableros
class SeleccionCantidadScreen extends StatefulWidget {
  const SeleccionCantidadScreen({super.key});

  @override
  State<SeleccionCantidadScreen> createState() =>
      _SeleccionCantidadScreenState();
}

class _SeleccionCantidadScreenState extends State<SeleccionCantidadScreen> {
  int cantidadTableros = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleccione Cantidad de Tableros de Cacho',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¿Cuántos tableros deseas ver?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<int>(
              value: cantidadTableros,
              items: List.generate(10, (index) => index + 1)
                  .map((num) =>
                      DropdownMenuItem(value: num, child: Text("$num")))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  cantidadTableros = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GrillaTablerosScreen(cantidad: cantidadTableros),
                  ),
                );
              },
              child: const Text(
                "Ver Tableros",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Segunda pantalla que muestra la grilla de tableros de Cacho
class GrillaTablerosScreen extends StatelessWidget {
  final int cantidad;

  const GrillaTablerosScreen({super.key, required this.cantidad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableros de Cacho"),
        backgroundColor: Colors.orange,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos tableros por fila
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: cantidad,
        itemBuilder: (context, index) {
          return CachoTablero(
            titulo: "Tablero ${index + 1}",
          );
        },
      ),
    );
  }
}

// Componente del tablero de Cacho individual
class CachoTablero extends StatefulWidget {
  final String titulo;

  const CachoTablero({super.key, required this.titulo});

  @override
  State<CachoTablero> createState() => _CachoTableroState();
}

class _CachoTableroState extends State<CachoTablero> {
  int balas = 0;
  int tontos = 0;
  int tricas = 0;
  int cuadras = 0;
  int quinas = 0;
  int senas = 0;
  String escalera = "0 pts";
  String full = "0 pts";
  String poker = "0 pts";

  void botonIncremento(String nombre) {
    setState(() {
      switch (nombre) {
        case "Balas":
          balas = (balas == 5) ? 0 : balas + 1;
          break;
        case "Tontos":
          tontos = (tontos == 10) ? 0 : tontos + 2;
          break;
        case "Tricas":
          tricas = (tricas == 15) ? 0 : tricas + 3;
          break;
        case "Cuadras":
          cuadras = (cuadras == 20) ? 0 : cuadras + 4;
          break;
        case "Quinas":
          quinas = (quinas == 25) ? 0 : quinas + 5;
          break;
        case "Senas":
          senas = (senas == 30) ? 0 : senas + 6;
          break;
      }
    });
  }

  Widget crearBoton(String nombre, int valor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
          ),
          onPressed: () => botonIncremento(nombre),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nombre,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "$valor pts",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    crearBoton("Balas", balas),
                    crearBoton("Cuadras", cuadras),
                  ],
                ),
                Row(
                  children: <Widget>[
                    crearBoton("Tontos", tontos),
                    crearBoton("Quinas", quinas),
                  ],
                ),
                Row(
                  children: <Widget>[
                    crearBoton("Tricas", tricas),
                    crearBoton("Senas", senas),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
