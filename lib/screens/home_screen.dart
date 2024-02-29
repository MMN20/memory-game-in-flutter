import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_memory_game/models/memory_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MemoryGame memoryGame = MemoryGame();
  DataItem? number1 = null;
  DataItem? number2 = null;
  int correctAnswers = 0;
  bool allowClick = true;

  void startTimer(void Function() fn) {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      timer.cancel();
      fn();
    });
  }

  bool isStarted = false;
  bool firstTime = true;

  void winningEvent() {
    if (correctAnswers == 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You won!')));
    }
  }

  void startRestartButton() {
    firstTime = false;
    memoryGame.randomizeData();
    number1 = null;
    number2 = null;
    correctAnswers = 0;
    isStarted = true;
    setState(() {});
  }

  void restartTheGame() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: GridView.builder(
                  itemCount: 16,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    DataItem dataItem = memoryGame.data[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (!dataItem.isClicked && allowClick && isStarted) {
                          setState(() {
                            dataItem.isClicked = true;
                          });
                          if (number1 == null) {
                            number1 = dataItem;
                          } else {
                            number2 = dataItem;
                            allowClick = false;
                            startTimer(() {
                              if (number1!.number != number2!.number) {
                                number1!.isClicked = false;
                                number2!.isClicked = false;
                              } else {
                                correctAnswers++;
                                winningEvent();
                              }
                              allowClick = true;
                              number1 = null;
                              number2 = null;
                              setState(() {});
                            });
                          }
                        }
                      },
                      child: Card(
                        elevation: 5,
                        color: number1 == dataItem || number2 == dataItem
                            ? Colors.green
                            : Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            dataItem.isClicked ? '${dataItem.number}' : '',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12)),
              onPressed: startRestartButton,
              child: Text(
                firstTime ? 'Start' : 'Restart',
                style: TextStyle(fontSize: 25),
              )),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
