import 'package:flutter/material.dart';
import 'package:matric_app/features/core/model/quizprovider.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.questions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          int currentIndex = quizProvider.currentQuestionIndex;
          var currentQuestion = quizProvider.questions[currentIndex];
          double progress = (currentIndex + 1) / quizProvider.questions.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Question ${currentIndex + 1} of ${quizProvider.questions.length}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion.question,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              ...currentQuestion.answers.map((answer) {
                return RadioListTile<String>(
                  title: Text(answer.answer),
                  value: answer.identifier,
                  groupValue: quizProvider.selectedAnswers[currentQuestion.id],
                  onChanged: quizProvider.isSubmitted
                      ? null
                      : (value) {
                          quizProvider.selectAnswer(currentQuestion.id, value!);
                        },
                );
              }).toList(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentIndex > 0)
                      ElevatedButton(
                        onPressed: () => quizProvider.previousQuestion(),
                        child: Text('Previous'),
                      ),
                    if (currentIndex < quizProvider.questions.length - 1)
                      ElevatedButton(
                        onPressed: () => quizProvider.nextQuestion(),
                        child: Text('Next'),
                      ),
                    if (currentIndex == quizProvider.questions.length - 1 &&
                        !quizProvider.isSubmitted)
                      ElevatedButton(
                        onPressed: () => quizProvider.submitQuiz(),
                        child: Text('Submit'),
                      ),
                  ],
                ),
              ),
              if (quizProvider.isSubmitted)
                Center(
                  child: Text(
                    'Your score: ${quizProvider.score} / ${quizProvider.questions.length}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
