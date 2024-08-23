import 'dart:math';

class QuestionGenerator {
  static List<int> generateTwoRandomNumbers() {
    final random = Random();
    final num1 = random.nextInt(50); 
    final num2 = random.nextInt(50);
    final correctAnswer = num1 + num2; 
    return [num1, num2, correctAnswer];
  }
}
