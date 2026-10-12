import 'package:flutter/material.dart';

// Experiment 4: Fuel Efficiency Calculator App (StatefulWidget & Forms)
class Exp4FuelCalculatorPage extends StatefulWidget {
  const Exp4FuelCalculatorPage({super.key});

  @override
  State<Exp4FuelCalculatorPage> createState() => _Exp4FuelCalculatorPageState();
}

class _Exp4FuelCalculatorPageState extends State<Exp4FuelCalculatorPage> {
  // GlobalKey to identify and validate the Form
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage and read input values
  final _distanceController = TextEditingController();
  final _fuelController = TextEditingController();

  // State variable to store and display the result
  String _result = "";

  // Function to calculate fuel efficiency and update state
  void _calculateMileage() {
    // Validate form inputs first
    if (_formKey.currentState!.validate()) {
      double distance = double.parse(_distanceController.text);
      double fuel = double.parse(_fuelController.text);

      if (fuel == 0) {
        setState(() {
          _result = "Fuel consumed cannot be zero!";
        });
        return;
      }

      // Mileage Formula = Distance Traveled / Fuel Consumed
      double mileage = distance / fuel;
      String status = "";

      // Efficiency logic based on lab manual requirements
      if (mileage < 10) {
        status = "Poor Efficiency";
      } else if (mileage >= 10 && mileage <= 15) {
        status = "Average Efficiency";
      } else {
        status = "Excellent Efficiency";
      }

      // Update UI using setState()
      setState(() {
        _result =
            "Your car’s mileage is ${mileage.toStringAsFixed(1)} km/l – $status";
      });
    }
  }

  // Clear fields and result
  void _resetForm() {
    _distanceController.clear();
    _fuelController.clear();
    setState(() {
      _result = "";
    });
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Efficiency Calculator'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Link Form to GlobalKey
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Calculate Your Vehicle Mileage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Distance Traveled TextFormField
                TextFormField(
                  controller: _distanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Distance Traveled (in km)',
                    hintText: 'Type distance in km',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add_road),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field cannot be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter the valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Distance must be greater than 0';
                    }
                    return null; // Valid
                  },
                ),
                const SizedBox(height: 16),

                // Fuel Consumed TextFormField
                TextFormField(
                  controller: _fuelController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Fuel Consumed (in liters)',
                    hintText: 'Type fuel in liters',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.local_gas_station),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field cannot be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter the valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Fuel must be greater than 0';
                    }
                    return null; // Valid
                  },
                ),
                const SizedBox(height: 20),

                // Calculate Mileage Button
                ElevatedButton(
                  onPressed: _calculateMileage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Calculate Mileage'),
                ),
                const SizedBox(height: 10),

                // Reset Button
                OutlinedButton(
                  onPressed: _resetForm,
                  child: const Text('Reset'),
                ),
                const SizedBox(height: 24),

                // Display Result Card
                if (_result.isNotEmpty)
                  Card(
                    elevation: 4,
                    color: Colors.teal.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _result,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}