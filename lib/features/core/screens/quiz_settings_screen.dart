import 'package:flutter/material.dart';
import 'package:matric_app/features/core/model/quizprovider.dart';
import 'package:provider/provider.dart';

class QuizSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Settings'),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.questionPapers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: quizProvider.questionPapers.length,
            itemBuilder: (context, index) {
              var paper = quizProvider.questionPapers[index];
              bool isSelected =
                  quizProvider.visibleQuestionPapers.contains(paper);

              return CheckboxListTile(
                activeColor: Colors.blue,
                title: Text(paper['title'] ?? 'Unknown Title'),
                subtitle:
                    Text(paper['description'] ?? 'No description available'),
                value: isSelected,
                onChanged: (bool? value) {
                  if (value == true) {
                    quizProvider.addPaperToVisibleList(paper);
                  } else {
                    quizProvider.removePaperFromVisibleList(paper);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.save,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
