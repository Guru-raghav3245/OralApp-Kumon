import 'dart:math';

enum Operation { addition, subtraction, multiplication, division }

class QuestionGenerator {
  List<int> generateTwoRandomNumbers(Operation operation) {
    final random = Random();
    int num1 = 0;
    int num2 = 0;
    int correctAnswer = 0;

    if (operation == Operation.addition) {
      num1 = random.nextInt(50);
      num2 = random.nextInt(50);
      correctAnswer = num1 + num2;
    } 
    else if (operation == Operation.subtraction) {
      num1 = random.nextInt(50);
      num2 = random.nextInt(50);
      correctAnswer = num1 - num2;
    } 
    else if (operation == Operation.multiplication) {
      num1 = random.nextInt(10);
      num2 = random.nextInt(10);
      correctAnswer = num1 * num2;
    } 
    else if (operation == Operation.division) {
      num2 = random.nextInt(9) + 1; // num2 should be between 1 and 9
      correctAnswer = random.nextInt(10); // correctAnswer should be between 0 and 9
      num1 = num2 * correctAnswer; // num1 is a multiple of num2
    }

    return [num1, num2, correctAnswer];
  }
}



