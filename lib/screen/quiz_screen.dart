import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/Services/api_services.dart'; // Ensure this returns Future<List<dynamic>>
import 'package:quiz_app/Services/identifier.dart';
import 'package:quiz_app/const/color.dart';
import 'package:quiz_app/screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int correct = 0;
  int incorrect = 0;
  late Future<List<dynamic>> quiz;
  int second = 30;
  int currentIndexOfQuestion = 0;
  Timer? timer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    quiz = getQuizData(); // Ensure this returns Future<List<dynamic>>
    quiz.then((_) => startTimer());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<String> optionList = [];
  List<AnsweredQuestion> chooseList = [];

  List<Color> optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (second > 0) {
        setState(() {
          second--;
        });
      } else {
        gotNextQuestion();
      }
    });
  }

  void gotNextQuestion() {
    setState(() {
      isLoading = false;
      currentIndexOfQuestion++;
      if (currentIndexOfQuestion < quiz.toString().length) {
        resultColor();
        timer?.cancel();
        second = 30;
        startTimer();
      } else {
        timer?.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                correct, incorrect, currentIndexOfQuestion, chooseList),
          ),
        );
      }
    });
  }

  void resultColor() {
    setState(() {
      optionColor = List.generate(4, (_) => Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.blue, blue, darkblue],
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: quiz,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;

              if (!isLoading && data.isNotEmpty) {
                if (currentIndexOfQuestion < data.length) {
                  optionList = [
                    data[currentIndexOfQuestion]['ans1'],
                    data[currentIndexOfQuestion]['ans2'],
                    data[currentIndexOfQuestion]['ans3'],
                    data[currentIndexOfQuestion]['ans4'],
                  ];
                  optionList.shuffle();
                  isLoading = true;
                }
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: lightgrey, width: 3),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$second",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: CircularProgressIndicator(
                                  value: second / 60,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'images/black-hand-painted-question-mark.png',
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Question ${currentIndexOfQuestion + 1} of ${data.length}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data[currentIndexOfQuestion]['question'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: optionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var correctAns = data[currentIndexOfQuestion]['ans1'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (correctAns.toString() ==
                                    optionList[index].toString()) {
                                  optionColor[index] = Colors.green;
                                  correct++;
                                  chooseList.add(AnsweredQuestion(
                                      question: data[currentIndexOfQuestion]
                                          ['question'],
                                      answer1: data[currentIndexOfQuestion]
                                          ['ans1'],
                                      selectedAnswer:
                                          optionList[index].toString()));
                                } else {
                                  optionColor[index] = Colors.red;
                                  incorrect++;
                                  chooseList.add(AnsweredQuestion(
                                      question: data[currentIndexOfQuestion]
                                          ['question'],
                                      answer1: data[currentIndexOfQuestion]
                                          ['ans1'],
                                      selectedAnswer:
                                          optionList[index].toString()));
                                }
                                if (currentIndexOfQuestion < data.length - 1) {
                                  Future.delayed(
                                      const Duration(milliseconds: 400),
                                      gotNextQuestion);
                                } else {
                                  timer?.cancel();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                          correct,
                                          incorrect,
                                          currentIndexOfQuestion + 1,
                                          chooseList),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: optionColor[index],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                optionList[index].toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
