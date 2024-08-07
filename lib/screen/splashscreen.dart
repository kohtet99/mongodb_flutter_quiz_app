import 'package:flutter/material.dart';
import 'package:quiz_app/const/color.dart';
import 'package:quiz_app/screen/quiz_screen.dart';

class QuizSplashScreen extends StatelessWidget {
  const QuizSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue,
                  blue,
                  darkblue,
                ]),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Image.asset('images/black-hand-painted-question-mark.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome to our",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  "Quiz App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizScreen(),),);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
    );
  }
}
