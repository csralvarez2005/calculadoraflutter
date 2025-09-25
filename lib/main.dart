import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Avanzada',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// Pantalla de inicio
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calculate, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Calculadora Avanzada",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Realiza operaciones matemáticas avanzadas fácilmente\n***By Cesar Alvarez***",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CalculatorScreen()),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Comenzar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de calculadora
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _resultado = "";
  String _operacion = "";

  void _calcular(String tipo) {
    setState(() {
      if (_num1Controller.text.isEmpty || _num2Controller.text.isEmpty) {
        _resultado = "Error: ingrese ambos valores.";
        return;
      }

      double? n1 = double.tryParse(_num1Controller.text);
      double? n2 = double.tryParse(_num2Controller.text);

      if (n1 == null || n2 == null) {
        _resultado = "Error: solo se permiten números.";
        return;
      }

      switch (tipo) {
        case "suma":
          _operacion = "Suma";
          _resultado = "$n1 + $n2 = ${n1 + n2}";
          break;
        case "resta":
          _operacion = "Resta";
          _resultado = "$n1 - $n2 = ${n1 - n2}";
          break;
        case "multiplicacion":
          _operacion = "Multiplicación";
          _resultado = "$n1 × $n2 = ${n1 * n2}";
          break;
        case "division":
          if (n2 == 0) {
            _resultado = "Error: División por cero.";
            return;
          }
          _operacion = "División";
          int cociente = n1 ~/ n2;
          double residuo = n1 % n2;
          _resultado = "$n1 ÷ $n2 = Cociente: $cociente, Residuo: $residuo";
          break;
        case "potencia":
          _operacion = "Potenciación";
          _resultado = "$n1 ^ $n2 = ${pow(n1, n2)}";
          break;
        case "raiz":
          if (n2 == 0) {
            _resultado = "Error: índice de raíz no puede ser 0.";
            return;
          }
          _operacion = "Radicación";
          _resultado = "Raíz ${n2}-ésima de $n1 = ${pow(n1, 1 / n2)}";
          break;
        case "logaritmo":
          if (n1 <= 0 || n2 <= 0 || n2 == 1) {
            _resultado = "Error: log inválido (valores deben ser positivos y base≠1).";
            return;
          }
          _operacion = "Logaritmación";
          _resultado = "log base $n2 ($n1) = ${log(n1) / log(n2)}";
          break;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _resultado = "";
      _operacion = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
              decoration: const InputDecoration(labelText: "Primer número"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
              decoration: const InputDecoration(labelText: "Segundo número"),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: () => _calcular("suma"), child: const Text("Suma")),
                ElevatedButton(onPressed: () => _calcular("resta"), child: const Text("Resta")),
                ElevatedButton(onPressed: () => _calcular("multiplicacion"), child: const Text("Multiplicación")),
                ElevatedButton(onPressed: () => _calcular("division"), child: const Text("División")),
                ElevatedButton(onPressed: () => _calcular("potencia"), child: const Text("Potencia")),
                ElevatedButton(onPressed: () => _calcular("raiz"), child: const Text("Radicación")),
                ElevatedButton(onPressed: () => _calcular("logaritmo"), child: const Text("Logaritmo")),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _operacion.isNotEmpty ? "Operación: $_operacion" : "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _limpiar,
              icon: const Icon(Icons.refresh),
              label: const Text("Limpiar"),
            )
          ],
        ),
      ),
    );
  }
}