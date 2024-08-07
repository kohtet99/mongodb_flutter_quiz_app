import 'package:flutter/material.dart';
import 'package:quiz_app/const/color.dart';
import 'package:quiz_app/screen/splashscreen.dart';

class ResultScreen extends StatelessWidget {
  final int correct;
  final int incorrect;
  final int totalQuestion;
  final List chooseans;
  const ResultScreen(
    this.correct, 
    this.incorrect, 
    this.totalQuestion,
    this.chooseans,
    {super.key});

  @override
  Widget build(BuildContext context) {
    double correctPercentage = (correct / totalQuestion * 100);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.blue, blue, darkblue]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Congratulation",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Text(
                "${correctPercentage.toStringAsFixed(1)}%",
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Text(
                "Correct Answer: $correct",
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "Incorrect Answer :$incorrect",
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),

            Expanded(
              child: ListView.builder(
                itemCount: chooseans.length,
                itemBuilder: (context, index) {
                  var answeredQuestion = chooseans[index];
                  return ListTile(
                    title: Text(answeredQuestion.question,style: const TextStyle(fontSize: 15,color: Colors.white),),
                    subtitle: Column(
                      children: [
                        Text('Your answer: ${answeredQuestion.selectedAnswer}',style: TextStyle(color: answeredQuestion.selectedAnswer==answeredQuestion.answer1?Colors.green:Colors.red),),
                        Text('Correct Answr: ${answeredQuestion.answer1} ',style: const TextStyle(fontSize: 15,color: Colors.white),)

                      ],
                    ),
                  
                    
                  );
                },
              ),
            ),

              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizSplashScreen(),
                      ),
                    );
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
