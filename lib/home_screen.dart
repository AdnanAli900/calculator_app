import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'components/my_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userInput = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    //that is the scaffold
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userInput,
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(height: 40,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(

                          answer,
                          style: const TextStyle(fontSize: 40, color: Colors.teal
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyButton(
                            title: 'AC',
                            onPress: () {
                              setState(() {
                                userInput = '';
                                answer = '';
                              });
                            },
                          ),
                          MyButton(
                            title: '+/-',
                            onPress: () {
                              setState(() {
                                userInput += '+/-';
                              });
                            },
                          ),
                          MyButton(
                            title: '%',
                            onPress: () {
                              setState(() {
                                userInput += '%';
                              });
                            },
                          ),
                          MyButton(
                            title: '/',
                            onPress: () {
                              setState(() {
                                userInput += '/';
                              });
                            },
                            color: const Color(0xffffa00a),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '7', onPress: () => appendValue('7')),
                          MyButton(title: '8', onPress: () => appendValue('8')),
                          MyButton(title: '9', onPress: () => appendValue('9')),
                          MyButton(
                            title: 'x',
                            onPress: () {
                              setState(() {
                                userInput += '*'; // Correcting multiplication symbol
                              });
                            },
                            color: const Color(0xffffa00a),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '4', onPress: () => appendValue('4')),
                          MyButton(title: '5', onPress: () => appendValue('5')),
                          MyButton(title: '6', onPress: () => appendValue('6')),
                          MyButton(
                            title: '-',
                            onPress: () {
                              setState(() {
                                userInput += '-';
                              });
                            },
                            color: const Color(0xffffa00a),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '1', onPress: () => appendValue('1')),
                          MyButton(title: '2', onPress: () => appendValue('2')),
                          MyButton(title: '3', onPress: () => appendValue('3')),
                          MyButton(
                            title: '+',
                            onPress: () {
                              setState(() {
                                userInput += '+';
                              });
                            },
                            color: const Color(0xffffa00a),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '0', onPress: () => appendValue('0')),
                          MyButton(title: '.', onPress: () => appendValue('.')),
                          MyButton(
                            title: 'del',
                            onPress: () {
                              setState(() {
                                if (userInput.isNotEmpty) {
                                  userInput = userInput.substring(0, userInput.length - 1);
                                }
                              });
                            },
                          ),
                          MyButton(
                            title: '=',
                            onPress: () {
                              equalPress();
                            },
                            color: const Color(0xffffa00a),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to append values to the input string
  void appendValue(String value) {
    setState(() {
      userInput += value;
    });
  }

  // Corrected equalPress() function with try-catch for error handling
  void equalPress() {
    try {
      // Replace 'x' with '*' for correct parsing
      String finalUserInput = userInput.replaceAll('x', '*');

      // Create a parser instance
      Parser p = Parser();

      // Parse the user input into an expression
      Expression exp = p.parse(finalUserInput);

      // ContextModel helps with evaluating the expression
      ContextModel contextModel = ContextModel();

      // Evaluate the expression
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Store the answer
      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      // In case of an error, show 'Error' instead of crashing
      setState(() {
        answer = 'Error';
      });
    }
  }
}
