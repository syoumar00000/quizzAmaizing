import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myquizz/quizz-helper.dart';
import 'package:http/http.dart' as http;
import 'package:myquizz/result-screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  State<QuizzScreen> createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  String apiUrl =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";
  QuizzHelper quizzHelper = QuizzHelper();
  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedSecond = 0;
  late Timer timer;
  int score = 0;
  @override
  void initState() {
    showAllQuizz();
    super.initState();
  }

  showAllQuizz() async {
    var response = await http.get(Uri.parse(apiUrl));
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      quizzHelper = QuizzHelper();
      quizzHelper = QuizzHelper.fromJson(json);
      quizzHelper.results![currentQuestion].incorrectAnswers!
          .add(quizzHelper.results![currentQuestion].correctAnswer!);
      quizzHelper.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        t.cancel();
        changeQuestion();
      } else {
        setState(() {
          elapsedSecond = t.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizzHelper.results![currentQuestion].correctAnswer!;
    if (correctAnswer == answer) {
      score += 1;
    } else {
      print("wrong");
    }
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();
    if (currentQuestion == quizzHelper.results!.length - 1) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: score)));
    } else {
      setState(() {
        currentQuestion += 1;
      });
      quizzHelper.results![currentQuestion].incorrectAnswers!
          .add(quizzHelper.results![currentQuestion].correctAnswer!);

      quizzHelper.results![currentQuestion].incorrectAnswers!.shuffle();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizzHelper.results == null) {
      return const Scaffold(
        backgroundColor: Color(0XFF2D046E),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (quizzHelper.results!.isNotEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF2D046E),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Image(
                      image: AssetImage("assets/logo.png"),
                      width: 70,
                      height: 70,
                    ),
                    Text(
                      "$elapsedSecond s",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Q. ${quizzHelper.results![currentQuestion].question}",
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: quizzHelper
                      .results![currentQuestion].incorrectAnswers!
                      .map((option) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            primary: const Color(0xFF511AA8),
                            onPrimary: Colors.white),
                        onPressed: () {
                          checkAnswer(option);
                        },
                        child: Text(
                          option,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        backgroundColor: Color(0XFF2D046E),
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
