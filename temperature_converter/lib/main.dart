import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TempConverter(),
    );
  }
}

class TempConverter extends StatefulWidget {
  const TempConverter({super.key});

  @override
  State<TempConverter> createState() => _TempConverterState();
}

class _TempConverterState extends State<TempConverter> {
  final TextEditingController _controller = TextEditingController();
  String _inputScale = "Celsius";
  String _outputScale = "Fahrenheit";
  String _result = "";

  // 🔹 Conversion Function
  String convertTemp(String input, String from, String to) {
    if (input.isEmpty) return "Please enter a value!";
    try {
      double value = double.parse(input);

      // Step 1: Convert to Celsius
      double celsius;
      if (from == "Celsius") {
        celsius = value;
      } else if (from == "Fahrenheit") {
        celsius = (value - 32) * 5 / 9;
      } else {
        celsius = value - 273.15; // Kelvin → Celsius
      }

      // Step 2: Convert Celsius → Output
      double result;
      if (to == "Celsius") {
        result = celsius;
      } else if (to == "Fahrenheit") {
        result = (celsius * 9 / 5) + 32;
      } else {
        result = celsius + 273.15; // Celsius → Kelvin
      }

      return "$input $from = ${result.toStringAsFixed(2)} $to";
    } catch (e) {
      return "Invalid input! Enter a number.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Converter"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter Temperature",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _inputScale,
                  items: const [
                    DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                    DropdownMenuItem(
                      value: "Fahrenheit",
                      child: Text("Fahrenheit"),
                    ),
                    DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _inputScale = value!;
                    });
                  },
                ),
                const Icon(Icons.arrow_forward, size: 30),
                DropdownButton<String>(
                  value: _outputScale,
                  items: const [
                    DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                    DropdownMenuItem(
                      value: "Fahrenheit",
                      child: Text("Fahrenheit"),
                    ),
                    DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _outputScale = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = convertTemp(
                    _controller.text,
                    _inputScale,
                    _outputScale,
                  );
                });
              },
              child: const Text("Convert"),
            ),
            const SizedBox(height: 20),

            // Result
            Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
