import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final a = TextEditingController();
  final b = TextEditingController();
  final op = TextEditingController();

  double result = 0.0;

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      ),
    );
  }

  void calculate() {
    final double? num1 = double.tryParse(a.text);
    final double? num2 = double.tryParse(b.text);
    final String operator = op.text.trim();

    if (num1 == null || num2 == null) {
      showError("Please enter valid numbers");
      return;
    }

    setState(() {
      switch (operator) {
        case "+":
          result = num1 + num2;
          break;
        case "-":
          result = num1 - num2;
          break;
        case "*":
          result = num1 * num2;
          break;
        case "/":
          if (num2 == 0) {
            showError("Cannot divide by zero");
          } else {
            result = num1 / num2;
          }
          break;
        default:
          showError("Invalid operator. Use +, -, *, or /");
      }
    });
  }

  @override
  void dispose() {
    a.dispose();
    b.dispose();
    op.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Basic Calculator",
          style: TextStyle(color: Colors.white), // Changed white12 to white
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ), // Removed the extra closing parenthesis that was here
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: a,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Number 1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: op,
              decoration: const InputDecoration(
                labelText: "Operator",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: b,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Number 2",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 30),
            Text(
              "Result: $result",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
