import 'package:flutter/material.dart';
import 'package:matric_app/features/core/model/quizprovider.dart';
import 'package:matric_app/features/core/screens/quiz_instruction_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'quiz_settings_screen.dart'; // Import the settings screen

class QuizListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.visibleQuestionPapers.isEmpty) {
            quizProvider.fetchQuestionPapers();
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: quizProvider.visibleQuestionPapers.length,
            itemBuilder: (context, index) {
              var paper = quizProvider.visibleQuestionPapers[index];
              return Card(
                margin: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizInstructionScreen(paperId: paper['id']),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (paper['image_url'] != null &&
                            paper['image_url'].isNotEmpty)
                          SvgPicture.asset(
                            paper['image_url'],
                            height:
                                100, // Adjust the height and width as needed
                            width: 100,
                          ),
                        SizedBox(height: 10),
                        Text(
                          paper['title'] ?? 'Unknown Title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          paper['description'] ?? 'No description available',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Questions Count: ${paper['questions_count'] ?? 0}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
