import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Quizzler(),
      ),
    );
  }
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Quizpage(),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Widget> scoreKeeper = [];

  void correctAnswer(bool userAnswer) {
    bool correctAnswers = myQuiz.getAnswers();

    setState(() {
      if (myQuiz.finished == true) {
        Alert(
                context: context,
                title: "Questions finished",
                desc: "You have gone through all the questions")
            .show();
        myQuiz.reset();
        scoreKeeper.clear();
      } else {
        if (userAnswer == correctAnswers) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        myQuiz.nextQuestion();
      }
    });
  }

  Quizbrain myQuiz = Quizbrain();

  int questionTracker = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              myQuiz.getQuestions(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: TextButton(
              onPressed: () {
                correctAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.green,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: TextButton(
              onPressed: () {
                correctAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.red,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper),
      ],
    );
  }
}
