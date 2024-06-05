import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matric_app/features/core/model/question_model.dart';

class QuestionController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Question>> fetchQuestions(String paperId) async {
    List<Question> questions = [];
    try {
      print('Fetching questions for paper $paperId...');
      QuerySnapshot questionsSnapshot = await _firestore
          .collection('questionsPapers')
          .doc(paperId)
          .collection('questions')
          .get();

      for (var questionDoc in questionsSnapshot.docs) {
        var data = questionDoc.data() as Map<String, dynamic>;
        var correctAnswer = data['correct_answer'] ?? '';
        var questionText = data['question'] ?? '';

        QuerySnapshot answersSnapshot =
            await questionDoc.reference.collection('answers').get();
        var answers = answersSnapshot.docs
            .where((doc) => doc.exists && doc.data() != null)
            .map((doc) =>
                Answer.fromFirestore(doc.data() as Map<String, dynamic>))
            .toList();

        var question = Question(
          id: questionDoc.id,
          question: questionText,
          correctAnswer: correctAnswer,
          answers: answers, imageUrl: '',
        );

        questions.add(question);
      }
      print('Fetched ${questions.length} questions.');
    } catch (e) {
      print('Error fetching questions: $e');
    }
    return questions;
  }
}
