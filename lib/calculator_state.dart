import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

// State class to hold calculator state
class CalculatorState {
  final String userInput;
  final String answer;

  const CalculatorState({
    this.userInput = '',
    this.answer = '',
  });

  // Create a new state object with updated values
  CalculatorState copyWith({
    String? userInput,
    String? answer,
  }) {
    return CalculatorState(
      userInput: userInput ?? this.userInput,
      answer: answer ?? this.answer,
    );
  }
}

// StateNotifier to handle calculator logic
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(const CalculatorState());

  // Add digit or operator
  void addInput(String value) {
    if (state.userInput == '0') {
      state = state.copyWith(userInput: value);
    } else {
      state = state.copyWith(userInput: state.userInput + value);
    }
  }

  // Clear all inputs
  void clear() {
    state = const CalculatorState(userInput: '0', answer: '');
  }

  // Delete last character
  void delete() {
    if (state.userInput.isNotEmpty) {
      state = state.copyWith(
        userInput: state.userInput.substring(0, state.userInput.length - 1),
      );
    }
  }

  // Toggle sign
  void toggleSign() {
    if (state.userInput.startsWith('-')) {
      state = state.copyWith(userInput: state.userInput.substring(1));
    } else {
      state = state.copyWith(userInput: '-' + state.userInput);
    }
  }

  // Handle percentage
  void percentage() {
    if (state.userInput.isNotEmpty) {
      try {
        // Evaluate current expression first
        equalPress();

        // Convert the result to a percentage (divide by 100)
        double percentage = double.parse(state.answer) / 100;

        // Update state
        state = state.copyWith(
          userInput: state.userInput + '%',
          answer: percentage.toString(),
        );
      } catch (e) {
        state = state.copyWith(answer: "Error");
      }
    }
  }

  // Evaluate expression
  void equalPress() {
    try {
      String userInput = state.userInput;

      // Handle percentage operations
      if (userInput.contains('%')) {
        List<String> parts = userInput.split('%');
        if (parts.length == 2) {
          // If format is "X%Y", calculate X% of Y
          double percentage = double.parse(parts[0]) / 100;
          double value = double.parse(parts[1]);
          state = state.copyWith(answer: (percentage * value).toString());
          return;
        } else {
          // If format is just "X%", convert X to percentage
          double value = double.parse(parts[0]) / 100;
          state = state.copyWith(answer: value.toString());
          return;
        }
      }

      // Original calculation for other operations
      userInput = userInput.replaceAll('x', '*');
      Parser parser = Parser();
      Expression expression = parser.parse(userInput);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);

      // Round to a reasonable decimal place if needed
      if (eval == eval.toInt()) {
        state = state.copyWith(answer: eval.toInt().toString());
      } else {
        state = state.copyWith(answer: eval.toString());
      }
    } catch (e) {
      state = state.copyWith(answer: "Error");
    }
  }
}

// Create the providers
final calculatorProvider = StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});