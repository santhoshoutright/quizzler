import 'package:flutter/material.dart';
import 'quizz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizzlerPage(),
    );
  }
}

class QuizzlerPage extends StatelessWidget {
  const QuizzlerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Quizzler'),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Quizzler(),
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  QuizzBrain quizzBrain = QuizzBrain();
  List<Icon> scoreKeeper = [];

  _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
    ).show();
  }

  void checkAnswer(bool pickedAnswer) {
    bool correctAnswer = quizzBrain.getAnswer();
    bool isFinished = quizzBrain.isFinished();
    setState(() {
      if (isFinished) {
        Alert(
          context: context,
          type: AlertType.info,
          title: "Congradulations !",
          desc: "You have successfully, finished the quizz with Flutter.",
          buttons: [
            DialogButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              width: 120,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ).show();
        quizzBrain.reset();
        scoreKeeper = [];
      } else {
        if (pickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.greenAccent,
            size: 30.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.redAccent,
            size: 30.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ));
        }
        quizzBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                quizzBrain.getQuestion(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
              ),
              onPressed: () => checkAnswer(true),
              child: Text(
                'True',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent, // background
              ),
              onPressed: () => checkAnswer(false),
              child: Text(
                'False',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: scoreKeeper,
            ),
          ),
        ],
      ),
    );
  }
}
