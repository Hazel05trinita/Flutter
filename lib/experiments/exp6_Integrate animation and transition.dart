import 'package:flutter/material.dart';

class Exp6AnimationPage extends StatefulWidget {
  const Exp6AnimationPage({super.key});

  @override
  State<Exp6AnimationPage> createState() => _Exp6AnimationPageState();
}

class _Exp6AnimationPageState extends State<Exp6AnimationPage> {
  bool isLarge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrate Animations and Transitions'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: isLarge ? 300 : 150,
              height: isLarge ? 300 : 150,
              decoration: BoxDecoration(
                color: isLarge ? Colors.pink : Colors.purple,
                borderRadius: BorderRadius.circular(isLarge ? 40 : 20),
              ),
              child: const Center(
                child: Text(
                  'Flutter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLarge = !isLarge;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }
}
