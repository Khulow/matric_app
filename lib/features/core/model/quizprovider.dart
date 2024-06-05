import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matric_app/features/core/controllers/question_controller.dart';
import 'package:matric_app/features/core/model/question_model.dart';

class QuizProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final QuestionController _questionController = QuestionController();
  List<Map<String, dynamic>> questionPapers = [];
  List<Map<String, dynamic>> visibleQuestionPapers = [];
  String paperTitle = 'Unknown Paper Title';
  List<Question> questions = [];
  Map<String, String> selectedAnswers = {};
  bool isSubmitted = false;
  int score = 0;
  int currentQuestionIndex = 0;

  Future<void> fetchQuestionPapers() async {
    try {
      QuerySnapshot paperSnapshot =
          await _firestore.collection('questionsPapers').get();
      questionPapers = paperSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();
      visibleQuestionPapers =
          List.from(questionPapers); // Initialize visible papers
      notifyListeners();
    } catch (e) {
      print('Error fetching question papers: $e');
    }
  }

  Future<void> fetchQuizData(String paperId) async {
    try {
      DocumentSnapshot paperSnapshot =
          await _firestore.collection('questionsPapers').doc(paperId).get();
      if (paperSnapshot.exists && paperSnapshot.data() != null) {
        var data = paperSnapshot.data() as Map<String, dynamic>;
        paperTitle = data['title'] ?? 'Unknown Paper Title';
      } else {
        paperTitle = 'Unknown Paper Title';
      }

      questions = await _questionController.fetchQuestions(paperId);
      notifyListeners();
    } catch (e) {
      print('Error fetching quiz data: $e');
    }
  }

  void selectAnswer(String questionId, String answerId) {
    selectedAnswers[questionId] = answerId;
    notifyListeners();
  }

  void submitQuiz() {
    int totalScore = 0;

    for (var question in questions) {
      String? selectedAnswer = selectedAnswers[question.id];
      if (selectedAnswer != null && question.correctAnswer == selectedAnswer) {
        totalScore += 1;
      }
    }

    score = totalScore;
    isSubmitted = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      notifyListeners();
    }
  }

  void updateVisiblePapers(Map<String, bool> selectedPapers) {
    visibleQuestionPapers = questionPapers
        .where((paper) => selectedPapers[paper['id']] == true)
        .toList();
    notifyListeners();
  }

void addPaperToVisibleList(Map<String, dynamic> paper) {
    visibleQuestionPapers = List.from(visibleQuestionPapers)..add(paper);
    notifyListeners();
  }

  void removePaperFromVisibleList(Map<String, dynamic> paper) {
    visibleQuestionPapers = List.from(visibleQuestionPapers)..remove(paper);
    notifyListeners();
  }




}
