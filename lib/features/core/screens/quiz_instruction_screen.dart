import 'package:flutter/material.dart';
import 'package:matric_app/features/core/model/quizprovider.dart';
import 'package:matric_app/features/core/screens/quizscreen.dart';
import 'package:provider/provider.dart';
 

class QuizInstructionScreen extends StatelessWidget {
  final String paperId;

  const QuizInstructionScreen({super.key, required this.paperId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Instructions'),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          var paper = quizProvider.questionPapers
              .firstWhere((paper) => paper['id'] == paperId);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.book, size: 28, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      paper['title'] ?? 'Unknown Title',
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.description, size: 28, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        paper['description'] ?? 'No description available',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.question_mark_outlined, size: 28, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      'Number of questions: ${paper['questions_count'] ?? 0}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.info, size: 28, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'You are to be evaluated on this paper. Keep in mind each time you take a quiz, you will be presented with random questions. Make sure to answer all the questions to the best of your ability.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      quizProvider.fetchQuizData(paperId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(),
                        ),
                      );
                    },
                    child: const Text('Start Quiz'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
