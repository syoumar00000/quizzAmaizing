import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myquizz/quizz-screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "productsans",
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Color(0xFF2D046E),
    ));
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
                "Quizz",
                style: TextStyle(fontSize: 90, color: Color(0xFFA20CBE)),
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
                    "PLAY",
                    style: TextStyle(fontSize: 32),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFFBA00),
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
