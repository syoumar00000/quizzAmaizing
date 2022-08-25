import 'package:flutter/material.dart';
import 'package:myquizz/quizz-screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.score}) : super(key: key);
  final int score;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  width: 300,
                  height: 300,
                ),
              ),
              const Text(
                "Result",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              Text(
                "${widget.score}/10",
                style: const TextStyle(fontSize: 60, color: Color(0xFFFFBA00)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizzScreen()),
                    );
                  },
                  child: const Text(
                    "RESTART",
                    style: TextStyle(fontSize: 32),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFFBA00),
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "EXIT",
                    style: TextStyle(fontSize: 32),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF511AA8),
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
