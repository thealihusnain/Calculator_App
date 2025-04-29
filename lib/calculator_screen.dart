import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/buttons.dart';
import 'calculator_state.dart';

class Calculator extends ConsumerWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatorState = ref.watch(calculatorProvider);
    final calculator = ref.read(calculatorProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: 330, // Fixed height container for stability
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                  children: [
                    Container(
                      height: 200, // Fixed height container for stability
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                        children: [
                          // Input display - scrollable horizontally (single line)
                          Container(
                            width: double.infinity,
                            height: 60, // Fixed height for input
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              physics: const ClampingScrollPhysics(), // Smooth scrolling
                              child: Text(
                                calculatorState.userInput,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.right,
                                softWrap: false,
                              ),
                            ),
                          ),
                          // Answer display - vertically scrollable when needed
                          Container(
                            width: double.infinity,
                            height: 120,
                            alignment: Alignment.topRight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical, // Vertical scrolling for multi-line answers
                              reverse: false,
                              child: Text(
                                calculatorState.answer,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.right,
                                softWrap: true, // Allow text to wrap to next line
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyButtons(
                          title: 'AC',
                          onPress: () => calculator.clear(),
                        ),
                        MyButtons(
                          title: '+/-',
                          onPress: () => calculator.toggleSign(),
                        ),
                        MyButtons(
                          title: '%',
                          onPress: () => calculator.percentage(),
                        ),
                        MyButtons(
                          title: '/',
                          color: const Color(0xffffa00a),
                          onPress: () => calculator.addInput('/'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButtons(
                          title: '7',
                          onPress: () => calculator.addInput('7'),
                        ),
                        MyButtons(
                          title: '8',
                          onPress: () => calculator.addInput('8'),
                        ),
                        MyButtons(
                          title: '9',
                          onPress: () => calculator.addInput('9'),
                        ),
                        MyButtons(
                          title: 'x',
                          color: const Color(0xffffa00a),
                          onPress: () => calculator.addInput('x'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButtons(
                          title: '4',
                          onPress: () => calculator.addInput('4'),
                        ),
                        MyButtons(
                          title: '5',
                          onPress: () => calculator.addInput('5'),
                        ),
                        MyButtons(
                          title: '6',
                          onPress: () => calculator.addInput('6'),
                        ),
                        MyButtons(
                          title: '-',
                          color: const Color(0xffffa00a),
                          onPress: () => calculator.addInput('-'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButtons(
                          title: '1',
                          onPress: () => calculator.addInput('1'),
                        ),
                        MyButtons(
                          title: '2',
                          onPress: () => calculator.addInput('2'),
                        ),
                        MyButtons(
                          title: '3',
                          onPress: () => calculator.addInput('3'),
                        ),
                        MyButtons(
                          title: '+',
                          color: const Color(0xffffa00a),
                          onPress: () => calculator.addInput('+'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButtons(
                          title: '0',
                          onPress: () => calculator.addInput('0'),
                        ),
                        MyButtons(
                          title: '.',
                          onPress: () => calculator.addInput('.'),
                        ),
                        MyButtons(
                          title: 'Del',
                          onPress: () => calculator.delete(),
                        ),
                        MyButtons(
                          title: '=',
                          color: const Color(0xffffa00a),
                          onPress: () => calculator.equalPress(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}